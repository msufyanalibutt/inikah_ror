module SearchConcern
  extend ActiveSupport::Concern

  included do
    def filter_users
      filters = params[:filters] || {}

      @users = User.all.where.not(id: current_user&.id)

      apply_city_filter(filters[:city])
      apply_age_filter(filters[:age])
      apply_username_filter(filters[:username])
      apply_education_filter(filters[:education])
      apply_income_filter(filters[:income])
      apply_height_filter(filters[:height])
      apply_weight_filter(filters[:weight])
      apply_native_filter(filters[:native])
      apply_religion_filter(filters[:religion])
      apply_marital_filter(filters[:marital])
      apply_hobbies_filter(filters[:hobbies])
    end

    def apply_city_filter(city)
      return if city.blank?

      @users = @users.where(city: city)
    end

    def apply_age_filter(age)
      return if age.blank?

      min, max = age.split('-').map(&:to_i)

      @users = @users.where('age >= ?', min) if min.present?
      @users = @users.where('age <= ?', max) if max.present?
    end

    def apply_username_filter(username)
      return if username.blank?

      @users = @users.where('username LIKE (?)', "%#{username}%")
    end

    def apply_education_filter(education)
      return if education.blank?

      @users = @users.where(education: education)
    end

    def apply_income_filter(income)
      return if income.blank?

      min, max = income.split('-').map(&:to_i)

      @users = @users.where('annual_income >= ?', min) if min.present?
      @users = @users.where('annual_income <= ?', max) if max.present?
    end

    def apply_height_filter(height)
      return if height.blank?

      min, max = height.split('-').map(&:to_i)

      @users = @users.where('height >= ?', min) if min.present?
      @users = @users.where('height <= ?', max) if max.present?
    end

    def apply_weight_filter(weight)
      return if weight.blank?

      min, max = weight.split('-').map(&:to_i)

      @users = @users.where('weight >= ?', min) if min.present?
      @users = @users.where('weight <= ?', max) if max.present?
    end

    def apply_native_filter(native)
      return if native.blank?

      @users = @users.where(native: native)
    end

    def apply_religion_filter(religion)
      return if religion.blank?

      @users = @users.where(religion: religion)
    end

    def apply_marital_filter(marital)
      return if marital.blank?

      @users = @users.where(marital_status: marital)
    end

    def apply_hobbies_filter(hobbies)
      return if hobbies.blank?

      @users = @users.where('hobbies LIKE (?)', "%#{hobbies}%")
    end
  end
end
