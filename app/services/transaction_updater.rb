class TransactionUpdater
  def initialize(transaction:, params:)
    @transaction = transaction
    @params = params
  end

  def update
    if @transaction.update(@params.except(:tags))
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
