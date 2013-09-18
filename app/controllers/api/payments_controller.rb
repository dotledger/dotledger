module Api
  class PaymentsController < BaseController
    def index
      @payments = Payment.all

      respond_with @payments
    end

    def show
      @payment = Payment.find(payment_id)

      respond_with @payment
    end

    def create
      @payment = Payment.new(payment_params)

      @payment.save

      respond_with @payment
    end

    def update
      @payment = Payment.find(payment_id)

      @payment.update(payment_params)

      respond_with @payment
    end

    def destroy
      @payment = Payment.find(payment_id)

      @payment.destroy

      respond_with @payment
    end

    private

    def payment_id
      params[:id].to_s
    end

    # TODO: add schedule
    def payment_params
      params.permit(:name, :amount, :category_id, :type)
    end
  end
end
