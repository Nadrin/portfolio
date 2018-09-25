require 'date'

module PortfolioHelper
    DATE_FORMAT = '%B %d, %Y'

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

    def article_items
        @items.find_all("/articles/**/index.md").sort { |a,b|
            b[:date] <=> a[:date]
        }
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

    def format_date(item_date)
        item_date.strftime(DATE_FORMAT)
    end
end