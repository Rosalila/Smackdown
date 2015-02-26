module ApplicationHelper

  def getCurrentTimeZone
    return "America/Tegucigalpa"
  end

  def userIsPlayingGame (user_id,game_id)
    upg = UserPlayingGame.where(:user_id=>user_id, :game_id=>game_id)[0]
    if upg == nil
      return false
    end
    return upg.is_playing
  end

  def pendingJudgeCount
    judge1_smackdowns = Smackdown.where(:judge1_id=>current_user.id, :judge1_accepted => nil)
    judge2_smackdowns = []
    Smackdown.where(:judge2_id=>current_user.id, :judge2_accepted => nil).each do |smackdown|
      next if smackdown.judge1_id==smackdown.judge2_id
      judge2_smackdowns.push(smackdown)
    end
    return judge1_smackdowns.count + judge2_smackdowns.count
  end

  def pendingRespondCount
    return Smackdown.where(:player2_id=>current_user.id, :player2_accepted=>nil).count
  end

  def watingOpponentCount
    return Smackdown.where(:player1_id=>current_user.id, :player2_accepted=>nil).count
  end

  def getWatingJudge
    smackdown_table = Smackdown.arel_table
    user_smackdowns=Smackdown.where(smackdown_table[:player1_id].eq(current_user.id).or(smackdown_table[:player2_id].eq(current_user.id)))
    different_judges = user_smackdowns.where("smackdowns.judge1_id != smackdowns.judge2_id").where(smackdown_table[:judge1_accepted].eq(nil).or(smackdown_table[:judge2_accepted].eq(nil)))
    same_judges = user_smackdowns.where("smackdowns.judge1_id == smackdowns.judge2_id").where(judge1_accepted: nil).where(judge2_accepted: nil)
    return different_judges + same_judges
  end


  def playingAtLeastAGame user
    at_least_a_game = false
    Game.all.each do |game|
      rules_ok = true
      game.rule_groups.each do |rule_group|
          at_least_a_rule = false
          rule_group.rules.each do |rule|
            if PlayerRule.where(:user_id=>user.id,:rule_id=>rule.id,:activated=>true)[0]!=nil
              at_least_a_rule = true
            end
          end
          if !at_least_a_rule || !userIsPlayingGame(user.id,game.id)
            rules_ok=false
          end
      end
      if rules_ok
        at_least_a_game = true
      end
    end
    return at_least_a_game
  end

  def getStats user1, user2
    user1_rechazadas = 0
    user2_rechazadas = 0
    user1_ganadas = 0
    user2_ganadas = 0
    conflictos = 0
    pendientes = 0
    errores = 0
    totales = 0

    Smackdown.where(:player1_id=>user1.id, :player2_id=>user2.id).each do |smackdown|
      if smackdown.player2_accepted == false
        user2_rechazadas+=1
      elsif smackdown.judge1_winner_id == user1.id && smackdown.judge2_winner_id == user1.id
        user1_ganadas+=1
      elsif smackdown.judge1_winner_id == user2.id && smackdown.judge2_winner_id == user2.id
        user2_ganadas+=1
      elsif smackdown.judge1_winner_id == nil || smackdown.judge2_winner_id == nil
        pendientes+=1
      elsif smackdown.judge1_winner_id != smackdown.judge2_winner_id
        conflictos+=1
      else
        errores+=1
      end
    end

    Smackdown.where(:player2_id=>user1.id, :player1_id=>user2.id).each do |smackdown|
      if smackdown.player2_accepted == false
        user1_rechazadas+=1
      elsif smackdown.judge1_winner_id == user1.id && smackdown.judge2_winner_id == user1.id
        user1_ganadas+=1
      elsif smackdown.judge1_winner_id == user2.id && smackdown.judge2_winner_id == user2.id
        user2_ganadas+=1
      elsif smackdown.judge1_winner_id == nil || smackdown.judge2_winner_id == nil
        pendientes+=1
      elsif smackdown.judge1_winner_id != smackdown.judge2_winner_id
        conflictos+=1
      else
        errores+=1
      end
    end

    return {'user1_rechazadas' => user1_rechazadas, 'user2_rechazadas' => user2_rechazadas, 'user1_ganadas' => user1_ganadas, 'user2_ganadas' => user2_ganadas, 'conflictos'=>conflictos, 'pendientes'=>pendientes, 'errores' => errores, 'totales'=>totales}
  end

  def annotationChartScript player1, player2
    str = "<script type=\"text/javascript\" src=\"https://www.google.com/jsapi?autoload={'modules':[{'name':'visualization','version':'1','packages':['annotationchart']}]}\"></script>"+
    "<script type='text/javascript'>"+
    "  google.load('visualization', '1', {'packages':['annotationchart']});"+
    "  google.setOnLoadCallback(drawChart);"+
    "  function drawChart() {"+
    "    var data = new google.visualization.DataTable();"+
    "    data.addColumn('date', 'Fecha');"+
    "    data.addColumn('number', 'Diferencia');"+
    "    data.addColumn('string', 'Evento');"+
    "    data.addColumn('string', 'Resultado');"+
    "    data.addRows(["
    difference = 0
    text_difference= ""
    Smackdown.where(player1_id: [player1.id,player2.id], player2_id: [player1.id,player2.id], judge1_winner_id: [player1.id,player2.id], judge2_winner_id: [player1.id,player2.id]).each do |smackdown|
      result = ""
      if smackdown.judge1_winner_id == player1.id && smackdown.judge2_winner_id == player1.id
        difference += 1
        result = "Ganador: " + player1.name
      elsif smackdown.judge1_winner_id == player2.id && smackdown.judge2_winner_id == player2.id
        difference -= 1
        result = "Ganador: " + player2.name
      end

      text_difference= "Empate"
      if difference>0
        text_difference = "(diferencia: +"+(difference.to_s)+" para "+player1.name+")"
      elsif difference<0
        text_difference = "+"+((-difference).to_s)+" para "+player2.name
      end

      str+="      [new Date("+ (smackdown.created_at.year.to_s) +", "+ ((smackdown.created_at.month-1).to_s) +", "+ (smackdown.created_at.day.to_s) +"), "+ (difference.to_s) + ", \"" + result + "\",  \"" + text_difference + "\"], "
    end
    today = Time.now.in_time_zone(getCurrentTimeZone)
    str+="      [new Date(" + (today.year).to_s + ", " + (today.month-1).to_s + ", " + (today.day).to_s + "), " + (difference.to_s) + ",'Actualidad', \"" + text_difference + "\"]"
    str+="    ]);"+
    "     var chart = new google.visualization.AnnotationChart(document.getElementById('annotation_div'));"+
    "     var options = {"+
    "       displayAnnotations: true"+
    "     };"+
    "    chart.draw(data, options);"+
    "  }"+
    "</script>"+
    "<body>"+
    "  <div id='annotation_div' style='width: 900px; height: 500px;'></div>"+
    "</body>"
    return str
  end

  def vsTable user1, user2
    str = "<table class='resizable_table'>"+
      "<tr>"+
        "<td>"+
          "<img class='resizable_image' src='http://graph.facebook.com/"+user1.uid+"/picture?type=normal'/>"+
        "</td>"+
        "<td>"+
          "<img class='resizable_image' src='/assets/Smackdown_150px/vs.png' />"+
        "</td>"+
        "<td>"+
          "<img class='resizable_image' src='http://graph.facebook.com/"+user2.uid+"/picture?type=normal'/>"+
        "</td>"+
      "</tr>"+
    "<table>"
    return str
  end

end
