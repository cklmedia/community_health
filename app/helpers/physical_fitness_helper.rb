module PhysicalFitnessHelper
  def is_active_tab_content(active_tab_name)
        r = active_tab_name == @active_tab ? "tab-pane fade active in" : "tab-pane fade"  
        r = "tab-pane fade active in" if active_tab_name =="health_bmds" && @active_tab.blank?
        r
    end

   def is_active_tab(active_tab_name)
        r = active_tab_name == @active_tab ? "active" : ""  
        r = "active" if active_tab_name =="health_bmds" && @active_tab.blank?
        r
    end
end
