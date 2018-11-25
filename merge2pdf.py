#!/usr/bin/env python3
# -*- coding: utf-8 -*-
'''
   #文件名：pdfmerge.py
   本脚本用来合并pdf文件，输出的pdf文件按输入的pdf文件名生成书签
   使用示例如下：
   python3 merge2pdf.py -p "D:\git\omnetppp_primer\pdf" -o "omnetpp_primer-zh.pdf" -b True'

   示例说明：
   要合并的pdf文件所在的路径： D:\pdf-files
   合并后的pdf文件的输出文件名：merged-out.pdf
   是否从pdf文件中导入书签的值：True
'''
import os, sys, codecs
from argparse import ArgumentParser, RawTextHelpFormatter
from PyPDF2 import PdfFileReader, PdfFileWriter, PdfFileMerger

def getfilenames(filepath='',filelist_out=[],file_ext='all'):
    # 遍历filepath下的所有文件，包括子目录下的文件
    for fpath, dirs, fs in os.walk(filepath):
        for f in fs:
            fi_d = os.path.join(fpath, f)
            if  file_ext == 'all':
                filelist_out.append(fi_d)
            elif os.path.splitext(fi_d)[1] == file_ext:
                filelist_out.append(fi_d)
            else:
                pass
    return filelist_out

def mergefiles(path, output_filename, import_bookmarks=False):
    # 遍历目录下的所有pdf将其合并输出到一个pdf文件中，输出的pdf文件默认带书签，书签名为之前的文件名
    # 默认情况下原始文件的书签不会导入，使用import_bookmarks=True可以将原文件所带的书签也导入到输出的pdf文件中
    merger = PdfFileMerger()
    filelist = getfilenames(filepath=path, file_ext='.pdf')
    if len(filelist) == 0:
        print("当前目录及子目录下不存在pdf文件")
        sys.exit()
    for filename in filelist:
        f = codecs.open(filename, 'rb')
        file_rd = PdfFileReader(f)
        short_filename = os.path.basename(os.path.splitext(filename)[0])
        if file_rd.isEncrypted == True:
            print('不支持的加密文件：%s'%(filename))
            continue
        merger.append(file_rd, bookmark=short_filename, import_bookmarks=import_bookmarks)
        print('合并文件：%s'%(filename))
        f.close()
    out_filename=os.path.join(os.path.abspath(path), output_filename)
    merger.write(out_filename)
    print('合并后的输出文件：%s'%(out_filename))
    merger.close()

if __name__ == "__main__":
    description="\n本脚本用来合并pdf文件，输出的pdf文件按输入的pdf文件名生成书签\n使用示例如下："
    description=description+'\npython merge2pdf.py -p "D:\git\omnetppp_primer\pdf" -o "omnetpp_primer-zh.pdf" -b True'
    description=description+'\n\n'+"示例说明："
    description=description+'\n'+"要合并的pdf文件所在的路径： D:\git\omnetppp_primer\pdf"
    description=description+'\n'+"合并后的pdf文件的输出文件名：omnetpp_primer-zh.pdf"
    description=description+'\n'+"是否从pdf文件中导入书签的值：True"

    # 添加程序帮助，程序帮助支持换行符号
    parser = ArgumentParser(description=description, formatter_class=RawTextHelpFormatter)

    # 添加命令行选项

    parser.add_argument("-p", "--path",
                        dest="path",
                        default=".",
                        help="PDF文件所在目录")
    parser.add_argument("-o", "--output",
                        dest="output_filename",
                        default="omnetpp_primer-zh.pdf",
                        help="合并PDF的输出文件名",
                        metavar="FILE")
    parser.add_argument("-b", "--bookmark",
                    dest="import_bookmarks",
                    default="False",
                    help="是否从pdf文件中导入书签，值可以是'True'或者'False'")

    args = parser.parse_args()
    #try:
    mergefiles(args.path, args.output_filename, args.import_bookmarks)
    #except:
    #    print('Error to merge pdf file:')
    #    print(sys.exc_info()[0],sys.exc_info()[1])
