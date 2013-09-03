FactoryGirl.define do
  factory :form do
    title "Test Form Title 1A2B"
    number  "1A2B"
    created_at  Date.today
    updated_at  Date.today
    icr_reference_number  "123456-1111-001"
    omb_control_number  "4040-0001"
    omb_expiration_date  1.year.from_now
    description 'A description for Form 1A2B'
    start_content  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis nec tincidunt nisl. Nunc a elit sit amet ante vehicula luctus vel faucibus massa. Donec sagittis imperdiet libero, sit amet vestibulum neque fermentum in. Quisque eros risus, egestas nec dignissim sit amet, dapibus sed tortor. Vestibulum et porttitor ligula. Sed dapibus justo nisi, sit amet aliquam dui ullamcorper eu. Pellentesque semper nulla sit amet justo pharetra tincidunt. Ut ultrices tortor massa, eget molestie enim congue porta. Nulla a varius leo, vel vestibulum est. Sed rutrum ullamcorper magna, ac condimentum libero adipiscing ac. Aenean eu tincidunt felis. Nulla facilisi. Cras sodales tincidunt leo at varius."
    need_to_know_content  "Donec malesuada neque sed suscipit placerat. In molestie viverra nunc sit amet sollicitudin. Nam tempus ligula ac iaculis fermentum. Cras consectetur orci volutpat justo dictum iaculis. Aenean ac mi at arcu adipiscing convallis. Mauris eget odio odio. Nunc nunc arcu, ornare quis adipiscing eu, tempor ornare felis. Aenean aliquam, diam sed mattis interdum, ante lectus vestibulum lorem, semper fringilla risus sem quis sem. Praesent quis volutpat lorem. Nullam id aliquet turpis. Sed sodales condimentum eleifend. Integer congue justo turpis, ut tristique justo imperdiet sed. Vivamus id tellus elit. Aliquam eu arcu in ipsum varius rhoncus."
    ways_to_apply_content  "Curabitur ultricies viverra est, non placerat justo lobortis id. Vivamus sed felis sed augue volutpat laoreet a eget magna. Nulla eros sapien, elementum quis felis at, rhoncus consequat urna. Morbi ornare mollis diam vel tristique. Quisque euismod non ipsum non aliquam. Pellentesque at blandit mauris, non auctor ligula. Ut tellus nisi, hendrerit nec feugiat nec, ornare euismod orci. Fusce consequat faucibus malesuada. Ut massa mauris, sodales id lacus placerat, ornare euismod nisl. Maecenas euismod auctor metus, sit amet imperdiet elit mollis et. Morbi magna ante, posuere vel enim id, scelerisque feugiat quam. Quisque ac odio sed sem aliquam tempor. Nulla sed tellus nec lorem porttitor malesuada."
    agency_name  "Test Government Agency"
    published_at  Date.today
  end
end