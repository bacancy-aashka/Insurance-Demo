class QuotationsController < ApplicationController

  def new
    @quotation = Quotation.new
    @quotation.build_address
  end

  def create_transaction
    @transaction = TransactionInfo.new(transaction_params)
    respond_to do |format|
      if @transaction.save
        if params[:request_callback]
          @res_type = 'Callback'
          @callback_information = CallbackInformation.new
        else
          @res_type = 'Payment'
          @card_information = CardInformation.new
        end
        format.js { render layout: false }
      else
        format.js { render layout: false, status: :unprocessable_entity }
      end
    end
  end

  def create_callback
    @callback_information = CallbackInformation.create(callback_params)
    redirect_to thank_you_quotations_path
  end

  def create_card_info
    @card_information = CardInformation.create(card_info_params)
    redirect_to thank_you_quotations_path
  end
  
  
  def create
    @quotation = Quotation.new(quotation_params)
    @quotation.insurance_value = @quotation.calculate_insurance_premium(@quotation.eval_value)

    respond_to do |format|
      if @quotation.save
        @transaction = create_new_transaction(@quotation)
        format.js { render layout: false }
        format.html { redirect_to root_path, notice: "Quotation was successfully created." }
        
      else
        format.js { render layout: false, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
        
      end
    end
  end

  private

    def quotation_params
      params.require(:quotation).permit(:first_name, :last_name, :email, :eval_value, :phone_number, address_attributes: [:address, :postal_code, :city, :province])
    end

    def transaction_params
      params.require(:transaction_info).permit(:language, :quotation_id, :home_owner_1, :home_owner_2, :home_owner_3, :property_type, :purchase_date, :lot_number, :bound_water, :muncipal_water, :insurance_issued, :insurance_denied, :note, :agent_name, :agent_email, address_attributes: [:address, :postal_code, :city, :province])
    end

    def card_info_params
      params.require(:card_information).permit(:postal_code, :card_number, :expiry_date, :card_name, :transaction_info_id, :cvv, :email, :transaction_info_id)
    end

    def callback_params
      params.require(:callback_information).permit(:phone_number, :call_availability, :transaction_info_id)
    end

    def create_new_transaction(quotation)
      transaction = TransactionInfo.new
      transaction.home_owner_1 = quotation.first_name + ' ' + quotation.last_name
      transaction.build_address
      transaction.address = quotation.address
      transaction
    end
    
    
    
    
end
