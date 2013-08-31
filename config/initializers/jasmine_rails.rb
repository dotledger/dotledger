if defined?(JasmineRails)
  module JasmineRails
    def self.spec_files
      files = []
      files += filter_files spec_dir, jasmine_config['boot_files']
      files += filter_files src_dir, jasmine_config['src_files']
      files += filter_files spec_dir, jasmine_config['helpers']
      files += filter_files spec_dir, jasmine_config['spec_files']
      files
    end
  end
end
