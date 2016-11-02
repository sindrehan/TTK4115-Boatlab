files = dir('*.fig')
for file = files'
    file.name
    openfig(file.name);
    export_fig(sprintf('../../Report/images/%s.pdf', file.name(1:end-4)));
    close all
end
 