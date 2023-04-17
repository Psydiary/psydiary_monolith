class PsydiaryFacade

  def initialize(params = {})
    @params = params
  end

  def new_user
   response = PsydiaryService.create_user(@params)
   user = JSON.parse(response.body, symbolize_names: true)
   return user[:errors] if user[:errors].present?
   User.new(user)
  end

  def user
    response = PsydiaryService.get_user(@params[:id])
    user = JSON.parse(response.body, symbolize_names: true)
    User.new(user)
  end

  def recent_entries
    response = PsydiaryService.get_recent_entries(@params[:id])
    entries_data = JSON.parse(response.body, symbolize_names: true)
    entries_data[:data][1..3].map do |entry|
      if entry[:attributes][:mood]
        DailyLogEntry.new(entry)
      else
        MicrodoseLogEntry.new(entry)
      end
    end
  end

  def authenticate_user
    user = PsydiaryService.authenticate_user(@params)
    return user = nil if user[:errors].present?
    User.new(user)
  end
end