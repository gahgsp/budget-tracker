class TransactionCreator
  # The "initialize" function is the constructor in Ruby.
  # It is executed when calling "new" to create an instance.
  # Having parameters with : in the function definition define them as "named parameters".
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def create
    @transaction = Transaction.new(@params.except(:tags))
    @transaction.user = @user

    if @transaction.save
      associate_tags
      attach_photo
      true
    else
      false
    end
  end

  private

  def associate_tags
    # logger.debug "Tags: #{tags_value}"
    return if @params[:tags].blank?

    tags_to_save = @params[:tags].split(",").map(&:strip).uniq

    saved_tags = tags_to_save.map do |name|
      Tag.find_or_create_by(name: name)
    end

    @transaction.tags = saved_tags
  end

  def attach_photo
    return unless @params[:photo].present?

    @transaction.photo.attach(@params[:photo])
  end
end
