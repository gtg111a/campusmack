namespace :tools do
  namespace :export do
    task :colleges => :environment do
      College.find_each do |record|
        puts "#{record.id} - #{record.name}"
      end
    end

    task :conferences => :environment do
      Conference.find_each do |record|
        puts "#{record.id} - #{record.name}"
      end
    end
  end

  task :upload_photos => :environment do
    raise "Set UPLOAD_BASE_PATH environment variable" if ENV['UPLOAD_BASE_PATH'].blank?
    @upload_user = User.first

    base_path = Dir.new(ENV['UPLOAD_BASE_PATH'])

    puts "Base Path: #{base_path.path}"
    puts "Upload User: #{@upload_user.email}"

    puts "========================================"
    puts "VERIFYING PARENTS"
    puts "========================================"

    terminate = false
    ['college', 'conference'].each do |parent_type|
      parent_type_path = File.join(base_path, "#{parent_type}s")
      next unless File.directory?(parent_type_path)

      (Dir.entries(parent_type_path) - ['.', '..']).each do |parent_name|
        parent = get_record(parent_type, parent_name)
        if parent.blank?
          puts "MISS: #{File.join(parent_type_path, parent_name)}"
          terminate = true
        end
      end
    end

    if terminate
      puts "----------------------------------------"
      puts "TERMINATING."
      puts "Please fix the college/conference names above."
      exit
    else
      puts "Passed."
    end

    puts "========================================"
    puts "PROCESSING PHOTOS"
    ['college', 'conference'].each do |parent_type|
      parent_type_path = File.join(base_path, "#{parent_type}s")
      next unless File.directory?(parent_type_path)

      puts "========================================"
      puts "#{parent_type.upcase}S:"
      puts "========================================"
      (Dir.entries(parent_type_path) - ['.', '..']).each do |parent_name|
        parent = get_record(parent_type, parent_name)
        parent_path = File.join(parent_type_path, parent_name)

        puts "#{parent_type.titlecase} ##{parent.id}: #{parent.name}"
        puts "(#{parent_path})"

        process_photos(parent, parent_path)
      end
    end
  end
end

def process_photos(parent, relative_path)
  return unless File.directory?(relative_path)

  puts "    Photos"
  puts "    ------"

  (Dir.entries(relative_path) - ['.', '..']).each do |file_name|
    file = File.open(File.join(relative_path, file_name), 'r')

    post = parent.smacks.build({
        :title => '',
        :summary => '',
        :photo_attributes => {
            :image => file
        }
    })
    post.user = @upload_user
    if post.save!
      puts "    [SAVE] #{file_name}"
    else
      puts "    [SKIP] #{file_name}"
    end

    file.close
  end
end

def get_record(record_type, record_name)
  record_type.camelcase.constantize.where('name LIKE ?', record_name).first
end
