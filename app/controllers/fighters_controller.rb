class FightersController < ApplicationController
  def new
    @fighter = Fighter.new
  end

  def create
    @fighter = Fighter.new(fighter_params)
    @fighter.save
    redirect_to root_path
  end


  def fighter_params
    params.require(:fighter).permit(:name, :attack, :type_gladiator, :endurance, :precision, :dodge, :armor, :resistance, :life)
  end
end
