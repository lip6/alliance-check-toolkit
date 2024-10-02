import re

file_name = "picorv32_m_without_modification.spi"
with open(file_name, 'r') as file:
    content = file.read()

content_modified = re.sub(r'\\\]', ']', re.sub(r'\\\[', '[', content))
with open('picorv32_m.spi', 'w') as file:
    file.write(content_modified)

