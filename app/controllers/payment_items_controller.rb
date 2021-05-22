class PaymentItemsController < ApplicationController
  before_action :set_payment_item, only: %i[ edit update destroy ]

  # GET /payments/1/edit
  def edit
  end

  # POST /payments or /payments.json
  def create
    @payment_item = PaymentItem.new(payment_item_params)

    respond_to do |format|
      if @payment_item.save
        format.html { redirect_to @payment, notice: "PaymentItem was successfully created." }
        format.json { render :show, status: :created, location: @payment_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment_item.update(payment_item_params)
        format.html { redirect_to @payment, notice: "Payment was successfully updated." }
        format.json { render :show, status: :ok, location: @payment_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment_item.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_item_params
      params.require(:payment_item).permit(:payment_id, :project_id, :hours_paid)
    end
end