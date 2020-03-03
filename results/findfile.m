files = dir('*.csv');
num_files = length(files);
x = cell(length(files), 1);
for i = 1:num_files
  x{i} = csvread(files(i).name);
end