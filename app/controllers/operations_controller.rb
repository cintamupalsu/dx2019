class OperationsController < ApplicationController
  def add
    @operation = Operation.new
    @vessel = Vessel.where("id=?",params[:vessel_id].to_i).first
  end

  def edit
    @operation = Operation.find(params[:operation_id].to_i)
  end

  def create
    @operation = Operation.new(operation_params)
    @vessel = Vessel.find(@operation.vessel_id)
    if @operation.save

      redirect_to vessel_path(@vessel)
    else
      render 'add'
    end
  end

  def delete
    operation = Operation.find(params[:operation_id].to_i)
    @vessel = Vessel.find(params[:vessel_id].to_i)
    operation.destroy
    redirect_to vessel_path(@vessel)
  end

  private
  def operation_params
    params.require(:operation).permit(:note, :kind, :address, :vessel_id)
  end

end
