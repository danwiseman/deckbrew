module HistoryHelper 
    
    def branches_and_merges(master_deck)
        
        history = Array.new
        
        
        for branch_me in @master_deck.branches
            history << { "type": "branch", "source_branch": branch_me.source_branch, "date": branch_me.created_at, "name": branch_me.name, "jsslug": branch_me.slug.gsub("-","") }
            merge_history = branch_me.merge_history
            unless merge_history.size == 0
               merge_history.each { |merge| history << { "type": "merge", "source_branch": merge['source_branch'], "date": merge['time'], "name": branch_me.name, "jsslug": branch_me.slug.gsub("-","") } } 
            end
        end
        
        history = history.sort_by { |hsh| hsh[:date] }
        
        history
    end
    
    def git_graph(master_deck)
        history = branches_and_merges(master_deck)
        timeline = ""
        
        for event in history
            timeline += graph_entry(event)
        end
        timeline.html_safe
    end
    
    def dashboard_timeline(master_deck)
        timeline = ""
        history = branches_and_merges(master_deck)
        timeline += tag.ul class: "timeline" do
            entries = ""
            for entry in history
               entries += dashboard_timeline_entry(entry) 
            end
            entries.html_safe 
        end
        timeline.html_safe 
    end
    
    def dashboard_timeline_entry(entry)
        entry_li = ""
        entry_li += tag.li class: "timeline-inverted" do
                        entry_divs = ""
                        entry_divs += tag.div class: "timeline-badge danger" do
                                        tag.i class: "fad fa-code-branch"
                                    end
                        entry_divs += tag.div class: "timeline-panel" do
                                        panel_text = ""
                                        panel_text += tag.span entry[:name], class: "badge badge-pill badge-danger"
                                        panel_text += tag.div class: "timeline-body" do
                                            body_text = ""
                                            body_text += tag.p entry[:type]
                                            body_text += tag.h6  do
                                                tag.i class: "ti-time"
                                                tag.time Time.zone.parse(entry[:date].to_s).utc.iso8601, class: "timeago", datetime: Time.zone.parse(entry[:date].to_s).utc.iso8601
                                            end
                                            body_text.html_safe 
                                        end
                                        panel_text.html_safe
                                    end
                        
                        entry_divs.html_safe 
                    end
        entry_li.html_safe             
    end
    
    def graph_entry(details)
        entry = ""
        source_branch = (details[:source_branch] == 0) ? "main" : Branch.find(details[:source_branch]).slug.gsub("-","")
        target_branch = details[:jsslug]
        if (details[:type] == "branch")
            source_branch_var = (source_branch == "main") ? "gitgraph" : source_branch
            entry += "const #{details[:jsslug]} = #{source_branch_var}.branch(\"#{details[:name]}\")\n"
            entry += "#{details[:jsslug]}.commit(\"branched on date\")\n"
        elsif (details[:type] == "merge")
            entry += "#{details[:jsslug]}.merge(#{source_branch})\n"
            #entry += "#{details[:jsslug]}.commit(\"merged on date\")\n"
        end
        
        entry
    end
    
    def sort_by_date(arr)
        arr.sort_by { |h| h["date"].split('/').reverse }
    end
    
end