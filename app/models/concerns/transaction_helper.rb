# This concern extracts common helper methods shared between "service objects".
#
# Using a "concern" follows Ruby on Rails best practices by:
# 1. DRY (Don't Repeat Yourself): Prevents code duplication across services;
# 2. Single Responsibility: Keeps helper logic separate from service logic;
# 3. Maintainability: Changes to helper methods only need to happen in one place;
# 4. Testability: Helper methods can be tested independently.
#
# Using "include TransactionHelper" to a "service object" class provides access to all the functions.
module TransactionHelper extend ActiveSupport::Concern
  # This file is a "module" as we do not need nor want to instantiate it.
  # The sole goal of this file is to share functions across other "classes".

  def associate_tags(transaction:, params:)
    # logger.debug "Tags: #{tags_value}"
    return if params[:tags].blank?

    tags_to_save = params[:tags].split(",").map(&:strip).uniq

    saved_tags = tags_to_save.map do |name|
      Tag.find_or_create_by(name: name)
    end

    transaction.tags = saved_tags
  end

  def attach_photo(transaction:, params:)
    return unless params[:photo].present?

    transaction.photo.attach(params[:photo])
  end
end
