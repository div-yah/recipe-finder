class IngredientProcessor
  MEASUREMENTS = %w(cup teaspoon package can tablespoon slice ounce sheet pint)

  FRACTIONS = {
    '½': '1/2',
    '⅓': '1/3',
    '⅔': '2/3',
    '¼': '1/4',
    '¾': '3/4',
    '⅛': '1/8',
    '⅜': '3/8',
    '⅝': '5/8',
    '⅞': '7/8'
  }

  attr_accessor :title

  def initialize(title)
    @title = title
  end

  def measurement_unit
    @measurement_unit ||= MEASUREMENTS.select {|m| title.include? m}[0]
  end

  def ingredient
    split_ingredient[0]
  end

  def amount
    @amount ||= if split_ingredient[1].present?
                  # Check for unicode fractions and replace to get raw amount
                  raw_amount = split_ingredient[1]
                  FRACTIONS.each { |k, v| raw_amount.sub!(k.to_s, v) }
                  Fractional.new(raw_amount).to_f
                end
  end


  def extra
    @extra ||= title[(title.index('(')+1)..(title.index(')')-1)] if ['(',')'].all? {|i| title.include? i}
  end

  def split_ingredient
    @split_ingredient ||= if measurement_unit.present? && !title.end_with?(measurement_unit)
                            # Split at the measurement unit
                            indx = title.index(measurement_unit)
                            [title[(indx+measurement_unit.length+1)..title.length], title[0..indx-1]].map(&:strip)
                          else
                            # Split at the first alphabetical char
                            indx = title =~ /[a-zA-Z]/
                            indx == 0 ? [title, nil] : [title[indx..title.length], title[0..indx]].map(&:strip)
                          end
  end
end
