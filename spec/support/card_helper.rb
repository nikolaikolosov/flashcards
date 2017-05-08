def review_date_helper(n)
  date = Time.now + card.interval.days
  expect(card.review_date.to_date).to eql(date.to_date)
  expect(card.level).to eql(n)
end

def card_successful(n, time)
  n.times do
    SuperMemo.new(card).successful(time)
  end
end

def card_failed(n)
  n.times do
    SuperMemo.new(card).failed
  end
end