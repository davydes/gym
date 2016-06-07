FactoryGirl.define do
  factory :workout_item, :class => Workout::Item do
    sets { { 1 => [160,2], 2 => [170,2]} }
    description 'Workout Item Description'
    pos { workout.items.count + 1 }
  end
end