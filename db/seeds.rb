# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create(name: 'Daigo')
u2 = User.create(name: 'Momochi')
u3 = User.create(name: 'Fuddo')

#Favorites

Favorite.create(user: u1, favorited_id: u3.id)
Favorite.create(user: u2, favorited_id: u1.id)
Favorite.create(user: u2, favorited_id: u3.id)

g1 = Game.create(name: "Street Fighter", image_path: "/assets/game_logos/ultra.png")
  rg11 = RuleGroup.create(game: g1, name: "Modo de juego")
    r111 = Rule.create(rule_group: rg11, name: "El que gane 2 de 3")
    r112 = Rule.create(rule_group: rg11, name: "El que gane 3 de 5")
    r113 = Rule.create(rule_group: rg11, name: "El primero en ganar 10")
  rg12 = RuleGroup.create(game: g1, name: "Tiempo")
    r121 = Rule.create(rule_group: rg12, name: "Infinito")
    r122 = Rule.create(rule_group: rg12, name: "99s")
  rg13 = RuleGroup.create(game: g1, name: "Rounds")
    r131 = Rule.create(rule_group: rg13, name: "1 round")
    r132 = Rule.create(rule_group: rg13, name: "2 rounds")


g2 = Game.create(name: "Guilty Gear", image_path: "/assets/game_logos/guilty_gear_xrd.png")
  rg21 = RuleGroup.create(game: g2, name: "Modo de juego")
    r211 = Rule.create(rule_group: rg21, name: "El que gane 2 de 3")
    r212 = Rule.create(rule_group: rg21, name: "El que gane 3 de 5")
    r213 = Rule.create(rule_group: rg21, name: "El primero en ganar 10")
  rg22 = RuleGroup.create(game: g2, name: "Tiempo")
    r221 = Rule.create(rule_group: rg22, name: "Infinito")
    r222 = Rule.create(rule_group: rg22, name: "99s")

g3 = Game.create(name: "Persona 4", image_path: "/assets/game_logos/persona4_arena_ultimax.png")
  rg31 = RuleGroup.create(game: g3, name: "Modo de juego")
    r311 = Rule.create(rule_group: rg31, name: "El que gane 2 de 3")
    r312 = Rule.create(rule_group: rg31, name: "El que gane 3 de 5")
    r313 = Rule.create(rule_group: rg31, name: "El primero en ganar 10")
  rg32 = RuleGroup.create(game: g3, name: "Rounds")
    r321 = Rule.create(rule_group: rg32, name: "1 round")
    r322 = Rule.create(rule_group: rg32, name: "2 rounds")

#User rules
upg1 = UserPlayingGame.create(user: u1, game: g1, is_playing: true)
upg2 = UserPlayingGame.create(user: u1, game: g2, is_playing: true)

upg3 = UserPlayingGame.create(user: u2, game: g1, is_playing: true)
upg4 = UserPlayingGame.create(user: u2, game: g2, is_playing: true)

upg5 = UserPlayingGame.create(user: u3, game: g1, is_playing: true)
upg6 = UserPlayingGame.create(user: u3, game: g3, is_playing: true)

upg6 = UserPlayingGame.create(user: u3, game: g3, is_playing: true)


pr1 = PlayerRule.create(rule: r111, user: u1, activated: true)
pr2 = PlayerRule.create(rule: r112, user: u1, activated: true)
pr3 = PlayerRule.create(rule: r121, user: u1, activated: true)
pr4 = PlayerRule.create(rule: r131, user: u1, activated: true)

pr5 = PlayerRule.create(rule: r111, user: u2, activated: true)
pr6 = PlayerRule.create(rule: r112, user: u2, activated: true)
pr7 = PlayerRule.create(rule: r121, user: u2, activated: true)
pr8 = PlayerRule.create(rule: r131, user: u2, activated: true)

pr9 = PlayerRule.create(rule: r211, user: u2, activated: true)
pr10 = PlayerRule.create(rule: r212, user: u2, activated: true)
pr11 = PlayerRule.create(rule: r221, user: u2, activated: true)

pr12 = PlayerRule.create(rule: r111, user: u3, activated: true)
pr13 = PlayerRule.create(rule: r112, user: u3, activated: true)
pr14 = PlayerRule.create(rule: r113, user: u3, activated: true)
pr15 = PlayerRule.create(rule: r121, user: u3, activated: true)
pr16 = PlayerRule.create(rule: r122, user: u3, activated: true)
pr17 = PlayerRule.create(rule: r131, user: u3, activated: true)
pr18 = PlayerRule.create(rule: r132, user: u3, activated: true)

#Historial enviados
s1 = Smackdown.create(player1_id: u1.id, player2_id: u2.id, judge1_id: u3.id, judge2_id: u3.id, judge1_winner_id: u1.id, judge2_winner_id: u1.id, player2_accepted: true, judge1_accepted: true, judge2_accepted: true)
  sr11 = SmackdownRule.create(smackdown: s1, rule: r111)
  sr11 = SmackdownRule.create(smackdown: s1, rule: r121)
  sr11 = SmackdownRule.create(smackdown: s1, rule: r131)

s2 = Smackdown.create(player1_id: u1.id, player2_id: u3.id, judge1_id: u2.id, judge2_id: u2.id, judge1_winner_id: u3.id, judge2_winner_id: u3.id, player2_accepted: true, judge1_accepted: true, judge2_accepted: true)
  sr21 = SmackdownRule.create(smackdown: s2, rule: r211)
  sr21 = SmackdownRule.create(smackdown: s2, rule: r221)

#Historial recibidos
s3 = Smackdown.create(player1_id: u2.id, player2_id: u1.id, judge1_id: u3.id, judge2_id: u3.id, judge1_winner_id: u1.id, judge2_winner_id: u1.id, player2_accepted: true, judge1_accepted: true, judge2_accepted: true)
  sr31 = SmackdownRule.create(smackdown: s3, rule: r311)
  sr31 = SmackdownRule.create(smackdown: s3, rule: r321)

s4 = Smackdown.create(player1_id: u3.id, player2_id: u1.id, judge1_id: u2.id, judge2_id: u2.id, judge1_winner_id: u3.id, judge2_winner_id: u3.id, player2_accepted: true, judge1_accepted: true, judge2_accepted: true)
  sr41 = SmackdownRule.create(smackdown: s4, rule: r211)
  sr41 = SmackdownRule.create(smackdown: s4, rule: r221)

#Historial juzgados
s5 = Smackdown.create(player1_id: u2.id, player2_id: u3.id, judge1_id: u1.id, judge2_id: u1.id, judge1_winner_id: u3.id, judge2_winner_id: u3.id, player2_accepted: true, judge1_accepted: true, judge2_accepted: true)
  sr41 = SmackdownRule.create(smackdown: s5, rule: r211)
  sr41 = SmackdownRule.create(smackdown: s5, rule: r221)

#Smackdown recibidos
s6 = Smackdown.create(player1_id: u2.id, player2_id: u1.id, judge1_id: u3.id)
  sr61 = SmackdownRule.create(smackdown: s6, rule: r211)
  sr61 = SmackdownRule.create(smackdown: s6, rule: r221)

#Juicio recibido
s7 = Smackdown.create(player1_id: u2.id, player2_id: u3.id, judge1_id: u1.id)
  sr71 = SmackdownRule.create(smackdown: s7, rule: r211)
  sr71 = SmackdownRule.create(smackdown: s7, rule: r221)

s7b = Smackdown.create(player1_id: u2.id, player2_id: u3.id, judge1_id: u1.id, judge2_id: u1.id)
  sr7b1 = SmackdownRule.create(smackdown: s7b, rule: r211)
  sr7b1 = SmackdownRule.create(smackdown: s7b, rule: r221)

#Esperando oponente
s8 = Smackdown.create(player1_id: u1.id, player2_id: u2.id, judge1_id: u3.id)
  sr81 = SmackdownRule.create(smackdown: s8, rule: r311)
  sr81 = SmackdownRule.create(smackdown: s8, rule: r321)

#Esperando juez
s9 = Smackdown.create(player1_id: u1.id, player2_id: u2.id, judge1_id: u3.id, judge2_id: u3.id, player2_accepted: true)
  sr91 = SmackdownRule.create(smackdown: s9, rule: r311)
  sr91 = SmackdownRule.create(smackdown: s9, rule: r321)
