from zipfile import ZipFile

zip_file="test.zip"

# Case 1
dst_dir="./result_data1"
zip_obj=ZipFile(zip_file)
zip_obj.extract('file1.txt', dst_dir)
zip_obj.extract('file2.txt', dst_dir)
zip_obj.close()

# Case 2
dst_dir="./result_data2"
zip_obj=ZipFile(zip_file)
zip_obj.extractall(dst_dir)
zip_obj.close()

# Case 3
dst_dir="./result_data3"
with ZipFile(zip_file, 'r') as zip_obj:
    zip_obj.extractall(dst_dir)

#import shutil
#shutil.unpack_archive(filename, extract_dir)