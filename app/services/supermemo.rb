class SuperMemo
  def initialize(card)
    @card = card
  end

  def successful(quality)
    @card.level += 1
    if @card.level == 1
      @card.interval = 1
    elsif @card.level == 2
      @card.interval = 6
    else
      @card.efactor = @card.efactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
      @card.efactor = 1.3 if @card.efactor < 1.3
      @card.interval *= @card.efactor
    end
    @card.review_date = Time.now + @card.interval.days
    @card.save
  end

  def failed
    if @card.mistake == 3
      @card.set_review_date
      @card.mistake = 0
      @card.level = 0
    else
      @card.mistake += 1
    end
    @card.save
  end
end