module RaterHelper
  def rating_for_user(rateable_obj, rating_user, dimension = nil, options = {})
    @object = rateable_obj
    @user = rating_user
    @rating = Rate.find_by_rater_id_and_rateable_id_and_dimension(@user.id, @object.id, dimension)
    star = options[:star] || 5
    stars = @rating ? @rating.stars : 0

    disable_after_rate = options[:disable_after_rate] || false

    readonly=false
    if disable_after_rate
      readonly = current_user.present? ? !rateable_obj.can_rate?(current_user.id, dimension) : true
    end

    content_tag :div, '', "data-dimension" => dimension, :class => "star", "data-rating" => stars,
    "data-id" => rateable_obj.id, "data-classname" => rateable_obj.class.name,
    "data-disable-after-rate" => disable_after_rate,
    "data-readonly" => readonly,
    "data-star-count" => star
  end

  def rate(stars, user_id, dimension=nil)
    if can_rate? user_id, dimension
      rates(dimension).build do |r|
        r.stars = stars
        r.rater_id = user_id
        r.save!          
      end      
      update_rate_average(stars, dimension)
    else
      raise "User has already rated...................."
    end
  end 

  def rate_text(star)
    case star
    when 1
        "Deadly"
    when 2
        "When a relative thinks they can cook"
    when 3
        "Good job. Was actually tasty"
    when 4
        "Someone's a Paul Hollywood in the making"
    else
        "This may pop Mary Berry's cherry again!"
    end
  end
end