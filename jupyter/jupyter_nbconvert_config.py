import os

c = get_config()

c.LatexExporter.template_path = ['.', os.path.expanduser('~/.jupyter/templates/latex')]
c.LatexExporter.template_file = 'unicode'
c.PDFExporter.latex_count = 3
c.PDFExporter.template_file = c.LatexExporter.template_file
c.PDFExporter.latex_command = ['pdflatex', '{filename}']

