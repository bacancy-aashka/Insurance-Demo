class QuotationsController < ApplicationController

  def new
    @quotation = Quotation.new
    @quotation.build_address
  end

  def create_transaction
    @transaction = TransactionInfo.new(transaction_params)
    respond_to do |format|
      if @transaction.save
        @res_type = if params[:commit] == 'Get a callback'
          'Callback'
        else
          'Payment'
        end
        if @res_type == 'Callback'
          @callback_information = CallbackInformation.new
        else
          @card_information = CardInformation.new
        end
        format.js { render layout: false }
      else
        format.js { render layout: false, status: :unprocessable_entity }
      end
    end
  end
  # param[res_type] / ternary operator

  def create_callback
    @callback_information = CallbackInformation.create(callback_params)
    redirect_to root_path
  end

  def create_card_info
    @card_information = CardInformation.create(card_info_params)
    redirect_to root_path
  end
  
  
  def create
    @quotation = Quotation.new(quotation_params)
    #  modal
    prime_tx = ((((@quotation.eval_value-500000)/1000)*1.17)+320)

    @quotation.insurance_value = ((prime_tx.round(2) + 20 + (prime_tx*0.09).round(2)).abs).round(2)

    respond_to do |format|
      if @quotation.save
        # after save callback
        @transaction = TransactionInfo.new
        @transaction.home_owner_1 = @quotation.first_name + ' '+ @quotation.last_name
        @transaction.build_address
        @transaction.address = @quotation.address
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
    
    
    
end
