namespace :pictures do

  desc "Recreate all pictures"
  task recreate: :environment do
    pictures = Picture.all
    puts 'Recreate started... ' + pictures.size.to_s + ' count'
    pictures.each do |p|
      begin
        puts 'Process: ' + p.id.to_s
        p.image.recreate_versions!
      rescue Exception => e
        puts e.message
      end
    end
  end

end
