class QuotationsController < ApplicationController
  before_action :set_quotation, only: %i[ show edit update destroy ]

  # GET /quotations or /quotations.json
  def index
    @quotations = Quotation.all
  end

  # GET /quotations/1 or /quotations/1.json
  def show
  end

  # GET /quotations/new
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
        format.html { redirect_to quotation_url(@transaction), notice: "Quotation was successfully created." }
      else
        format.js { render layout: false, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def create_callback
    @callback_information = CallbackInformation.new(params.require(:callback_information).permit!)
    if @callback_information.save
      respond_to do |format|
        format.html { redirect_to root_path}
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path }
      end
    end
    
  end

  def create_card_info
    @card_information = CardInformation.new(params.require(:card_information).permit!)
    if @card_information.save
      respond_to do |format|
        format.html { redirect_to root_path}
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path}
      end
    end
    
  end
  
  
  # GET /quotations/1/edit
  def edit
  end

  # POST /quotations or /quotations.json
  def create
    @quotation = Quotation.new(quotation_params)
    prime_tx = ((((@quotation.eval_value-500000)/1000)*1.17)+320)
    @quotation.insurance_value = ((prime_tx.round(2) + 20 + (prime_tx*0.09).round(2)).abs).round(2)

    respond_to do |format|
      if @quotation.save
        @transaction = TransactionInfo.new
        @transaction.home_owner_1 = @quotation.first_name + ' '+ @quotation.last_name
        @transaction.build_address
        @transaction.address = @quotation.address
        format.js { render layout: false }
        format.html { redirect_to quotation_url(@quotation), notice: "Quotation was successfully created." }
        
      else
        format.js { render layout: false, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
        
      end
    end
  end

  # PATCH/PUT /quotations/1 or /quotations/1.json
  # def update
  #   respond_to do |format|
  #     if @quotation.update(quotation_params)
  #       format.html { redirect_to quotation_url(@quotation), notice: "Quotation was successfully updated." }
  #       format.json { render :show, status: :ok, location: @quotation }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @quotation.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /quotations/1 or /quotations/1.json
  def destroy
    @quotation.destroy

    respond_to do |format|
      format.html { redirect_to quotations_url, notice: "Quotation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quotation
      @quotation = Quotation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quotation_params
      params.require(:quotation).permit(:first_name, :last_name, :email, :eval_value, address_attributes: [:address, :postal_code, :city, :province])
    end

    def transaction_params
      params.require(:transaction_info).permit(:language, :quotation_id, :home_owner_1, :home_owner_2, :home_owner_3, :property_type, :purchase_date, :lot_number, :bound_water, :muncipal_water, :insurance_issued, :insurance_denied, :note, :agent_name, :agent_email, address_attributes: [:address, :postal_code, :city, :province])
    end
    
end
