# ActionView::Base.field_error_proc = Proc.new do |html_tag, instance_tag|
#   fragment = Nokogiri::HTML.fragment(html_tag)
#   field = fragment.at('input,select,textarea')

#   model = instance_tag.object
#   error_message = model.errors.full_messages.join(', ')

#   html = if field
#            field['class'] = "#{field['class']} invalid"
#            html = <<-HTML
#               #{fragment.to_s}
#               <p class="error">#{error_message}</p>
#            HTML
#            html
#          else
#            html_tag
#          end

#   html.html_safe


# end

# ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
#   if instance.error_message.kind_of?(Array)
#     %(#{html_tag}<span class="validation-error">&nbsp;
#       #{instance.error_message.join(',')}</span>)
#   else
#     %(#{html_tag}<span class="validation-error">&nbsp;
#       #{instance.error_message}</span>)
#   end
# end