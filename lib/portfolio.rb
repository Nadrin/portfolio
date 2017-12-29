module PortfolioHelper
    def project_items(type)
        result = []
        @items.find_all("/projects/*.html").each do |item|
            include = false
            case type
            when :homepage
                include = item.fetch(:homepage, false)
            when :featured
                include = item.fetch(:featured, false)
            when :other
                include = !item.fetch(:featured, false)
            else
                raise ArgumentError, "Unknown project type"
            end

            result << item if include
        end
        result.sort { |a,b| b[:year] <=> a[:year] }
    end

    def year_of(project)
        project[:year].to_s.split('.')[0]
    end

    def page_url(item_path)
        if ENV['NANOC_ENV'] == 'prod'
            item_path.chomp(File.extname(item_path))
        else
            item_path
        end
    end
end