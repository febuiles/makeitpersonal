%w{app lib}.each do |dir|
  Dir[File.dirname(__FILE__) + "/../#{dir}/*"].each do |d|
    $: << d
  end
end
