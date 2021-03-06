class PropertiesController < ApplicationController

  def sort
    @sort_num = params[:id]
    @properties_count = current_company.properties.count
    @not_find_switch = false
    if @properties_count == 0
      @not_find_switch = true
      # 取得データの仮置(なんで置いたか忘れたけど、多分、@が見つからないって言われるからだと思う。)
      @properties = current_company.properties.order(created_at: "DESC")
    else
      if @sort_num == "1"
        @properties = current_company.properties.page(params[:page]).per(20).order(created_at: "DESC")
      elsif @sort_num == "2"
        @properties = current_company.properties.page(params[:page]).per(20).order(created_at: "ASC")
      elsif @sort_num == "3"
        @properties = current_company.properties.page(params[:page]).per(20).order(rank_id: "ASC")
      elsif @sort_num == "4"
        @properties = current_company.properties.page(params[:page]).per(20).order(rank_id: "DESC")
      elsif @sort_num == "5"
        @properties = current_company.properties.page(params[:page]).per(20).order(units: "DESC")
      elsif @sort_num == "6"
        @properties = current_company.properties.page(params[:page]).per(20).order(units: "ASC")
      else
        @properties = current_company.properties.page(params[:page]).per(20).order(created_at: "DESC")
      end
    end
  end
  
  def new
    @property_owner_utility_equipment_facility = PropertyOwnerUtilityEquipmentFacility.new
  end

  def create
    @property_owner_utility_equipment_facility = PropertyOwnerUtilityEquipmentFacility.new(property_owner_utility_equipment_facility_params)
    if @property_owner_utility_equipment_facility.valid?
      @property_owner_utility_equipment_facility.save
      flash[:notice] = '物件登録が完了しました！'
        redirect_to sort_property_path(1)
    else
      render action: :new
    end
  end

  def show
    @property = Property.find(params[:id])
  end

  private



  def property_owner_utility_equipment_facility_params
    params.require(:property_owner_utility_equipment_facility).permit(:company_id, :worker_id,:name, :name_kana, :post_code, :prefecture_id, :city, :street, :type_id, :units, :management_form_id, :rank_id, :caution, :image, :swicth_owner_form, :owner_company_name, :owner_company_name_kana, :last_name, :first_name, :last_name_kana, :first_name_kana, :gender, :character_id, :character_about, :owner_post_code, :owner_prefecture_id, :owner_city, :owner_street, :owner_building_name, :main_communication, :communication_about, :home_phone_num, :phone_num, :other_phone_num, :fax_num, :email, :w_company_name, :w_company_name_kana, :w_post_code, :w_prefecture_id, :w_city, :w_street, :w_building_name, :w_company_phone_num, :w_job_description, :water_supply_id, :sewer_id, :electrical_id, :ga_id)
  end



end