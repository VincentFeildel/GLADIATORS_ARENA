class FightsController < ApplicationController
  def show
    @fight = Fight.find(params[:id])
    @fighter_1 = Fighter.find(@fight.fighter_1).name
    @fighter_2 = Fighter.find(@fight.fighter_2).name
  end

  def fighting
    @fight = Fight.new
    @fighter_1 = Fighter.find(params[:Glad_1])
    @fighter_2 = Fighter.find(params[:Glad_2])
    @fight.fight_description = "AVE CESAR MORITURI TE SALUTANT\nLe duel tant attendu commence..\n"

    # Bonuses comes into play!!
    update_fighter_bonus(params[:bonus_1], @fighter_1, @fighter_2, @fight)
    update_fighter_bonus(params[:bonus_2], @fighter_2, @fighter_1, @fight)

    # Fight begins here!!
    while (@fighter_1.life > 0) && (@fighter_2.life > 0)
      run_round(@fighter_1, @fighter_2, @fight)
      fatigue(@fighter_1)
      fatigue(@fighter_2)
    end

    # Recording winner!
    @fight.winner = @fighter_1.life > 0 ? @fighter_1.name : @fighter_2.name
    @fight.fight_description += "\n\nLE GAGNANT EST #{@fight.winner} !!"

    @fight.fighter_2 = params[:Glad_2]
    @fight.fighter_1 = params[:Glad_1]
    @fight.save
    redirect_to fight_path(@fight)
  end

  def run_round(fighter_1, fighter_2, fight)
    attacking(fighter_1, fighter_2, fight)
    attacking(fighter_2, fighter_1, fight) if fighter_2.life > 0
  end

  def attacking(attacker, defender, fight)
    # Attacks hits the target?
    attack_hits = (rand(1..10) * attacker.precision.fdiv(defender.dodge)) >= 4
    if !attack_hits
      fight.fight_description += "\n#{attacker.name} a manqué son coup"
    else
      # Attack removes life from defender
      fight.fight_description += "\nLe coup de #{attacker.name} est réussi, la violence est totale: "
      defender.life -= ( ( ( 400 / defender.armor ) + ( 400 / defender.resistance ) ) * attacker.attack ) / 100
      fight.fight_description += "la vie de #{defender.name} est maintenant de #{defender.life}"
    end
  end

  def fatigue(fighter)
    fighter.resistance -= (100 / fighter.endurance) if fighter.resistance > 10
    fighter.precision -= (100 / fighter.endurance) if fighter.precision > 10
    fighter.dodge -= (100 / fighter.endurance) if fighter.dodge > 10
  end

  def update_fighter_bonus(bonus, fighter, opponent, fight)
    case bonus
      when "glaive sournois"
        fighter.attack += 10
        fight.fight_description += "\nC'est moi ou #{fighter.name} semble cacher un petit glaive bien vicieux dans sa sandale?"
      when "potion magique"
        fighter.endurance += 10
        fight.fight_description += "\n#{fighter.name} semble être dans une forme olympique ce soir, je me suis laissé dire qu'il n'a pas sifflé que de la cervoise.."
      when "poison"
        opponent.endurance -= 10
        fight.fight_description += "\n#{opponent.name} est blanc comme un linge, ça s'annonce difficile pour lui"
    end
  end
end
