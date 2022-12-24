class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show destroy]
  before_action :authenticate_user!
  load_and_authorize_resource param_method: :payment_params

  # GET /payments
  def index
    @payments = Payment.all
  end

  # GET /payments/1
  def show; end

  # GET /payments/new
  def new
    @payment = Payment.new
    @categories = Category.all.order(:name)
  end

  # POST /payments
  def create
    @payment = Payment.new(payment_params)
    @payment.categories << Category.find(params[:category_id])

    another_category = params[:payment][:cat_id]
    @payment.categories << Category.find(another_category) unless another_category.blank?
    @payment.user_id = current_user.id

    respond_to do |format|
      if @payment.save
        format.html { redirect_to category_path(params[:category_id]), notice: 'Payment was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  def destroy
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to category_path(params[:category_id]), notice: 'Payment was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:name, :amount)
  end
end
