// SwfDlg.cpp : 实现文件
//

#include "stdafx.h"
#include "Swf.h"
#include "SwfDlg.h"
#include "include/zlib.h"
#pragma comment(lib, "lib/zlib.lib")

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CSwfDlg 对话框


CSwfDlg::CSwfDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CSwfDlg::IDD, pParent)
{
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);
}

void CSwfDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CSwfDlg, CDialog)
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	//}}AFX_MSG_MAP
	ON_BN_CLICKED(IDOPEN1, &CSwfDlg::OnBnClickedOpen1)
	ON_BN_CLICKED(IDOPEN2, &CSwfDlg::OnBnClickedOpen2)
	ON_BN_CLICKED(IDDOWORK, &CSwfDlg::OnBnClickedDowork)
END_MESSAGE_MAP()


// CSwfDlg 消息处理程序

BOOL CSwfDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// 设置此对话框的图标。当应用程序主窗口不是对话框时，框架将自动
	//  执行此操作
	SetIcon(m_hIcon, TRUE);			// 设置大图标
	SetIcon(m_hIcon, FALSE);		// 设置小图标

	// TODO: 在此添加额外的初始化代码

	return TRUE;  // 除非将焦点设置到控件，否则返回 TRUE
}

// 如果向对话框添加最小化按钮，则需要下面的代码
//  来绘制该图标。对于使用文档/视图模型的 MFC 应用程序，
//  这将由框架自动完成。

void CSwfDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // 用于绘制的设备上下文

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// 使图标在工作区矩形中居中
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// 绘制图标
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

//当用户拖动最小化窗口时系统调用此函数取得光标
//显示。
HCURSOR CSwfDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}


void CSwfDlg::OnBnClickedOpen1()
{
	// TODO: 在此添加控件通知处理程序代码
	char oldPath[MAX_PATH];	// 保存当前工作目录
	GetCurrentDirectory( MAX_PATH, oldPath );

	// 打开 打开对话框
	static char BASED_CODE szFilter[] = "SWF Files (*.swf)|*.swf||";
	CFileDialog dlg(1,"swf",NULL,OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,szFilter,0,0);
	if(dlg.DoModal()==IDOK)
	{
		//获取文件名
		m_FileName = dlg.GetFileName();
		CString strPath = dlg.GetPathName();

		CEdit * pInEdit=(CEdit*)GetDlgItem( IDC_INPUT );
		CEdit * pOutEdit=(CEdit*)GetDlgItem( IDC_OUTPUT );
		pInEdit->SetWindowText( strPath );
		strPath.Insert( strPath.GetLength()-4, "_");
		pOutEdit->SetWindowText( strPath );
	}

	SetCurrentDirectory( oldPath );
}

void CSwfDlg::OnBnClickedOpen2()
{
	// TODO: 在此添加控件通知处理程序代码
	char oldPath[MAX_PATH];
	GetCurrentDirectory( MAX_PATH, oldPath );

	char szPath[MAX_PATH];     //存放选择的目录路径 
	CString str;

	ZeroMemory(szPath, sizeof(szPath));   

	BROWSEINFO bi;   
	bi.hwndOwner = m_hWnd;   
	bi.pidlRoot = NULL;   
	bi.pszDisplayName = szPath;   
	bi.lpszTitle = "请选择需要打包的目录：";   
	bi.ulFlags = 0;   
	bi.lpfn = NULL;   
	bi.lParam = 0;   
	bi.iImage = 0;   
	//弹出选择目录对话框
	LPITEMIDLIST lp = SHBrowseForFolder(&bi);   

	if(lp && SHGetPathFromIDList(lp, szPath))   
	{
		CString strPath = szPath;
		strPath += m_FileName;
		strPath.Insert( strPath.GetLength()-4, "_");
		CEdit * pOutEdit=(CEdit*)GetDlgItem( IDC_OUTPUT );
		pOutEdit->SetWindowText( strPath );
	}
	else
	{
		AfxMessageBox("无效的目录，请重新选择");
	}

	SetCurrentDirectory( oldPath );
}

void CSwfDlg::OnBnClickedDowork()
{
	// TODO: 在此添加控件通知处理程序代码

	CString strIn;	// 输入文件名
	CString strOut;	// 输出文件名
	CEdit* pInEdit=(CEdit*)GetDlgItem( IDC_INPUT );
	CEdit* pOutEdit=(CEdit*)GetDlgItem( IDC_OUTPUT );
	pInEdit->GetWindowText(strIn);
	pOutEdit->GetWindowText(strOut);

	CFile infile;
	if( !infile.Open( strIn, CFile::modeRead ) )
	{	
		AfxMessageBox( "无法打开文件" );
		return;
	}

	DWORD complen=(DWORD)infile.GetLength();	// 获取文件长度
	BYTE* header=(BYTE*)::GlobalAlloc(GPTR,8);	// 创建swf文件头存储空间
	infile.Read(header,8);						// 读取swf文件头
	DWORD filelen = *(DWORD*)(header+4);		// 获取文件信息中的文件长度

	// 简单测试一下是否为正常的swf文件
	if ( !( (header[0] == 'C' || header[0] == 'F') && header[1] == 'W' && header[2] == 'S' ) || complen > filelen )
	{
		AfxMessageBox( "文件不为SWF文件" );
		infile.Close();
		return;
	}

	// 创建文件缓存
	BYTE* buf=(BYTE*)::GlobalAlloc(GPTR,complen-8);
	BYTE* bufd=(BYTE*)::GlobalAlloc(GPTR,filelen-8);

	// 读取源swf数据
	infile.Read(buf,complen-8);
	infile.Close();

	unsigned long destlen;	// 压缩/解压后的长度

	// 根据文件头选择压缩/解压
	bool bCompress = header[0] == 'C';
	if( bCompress )
	{
		// 解压，并修改文件头信息
		uncompress( bufd, &destlen, buf, complen-8 );
		header[0] = 'F';
	}
	else
	{
		// 压缩，并修改文件头信息
		compress( bufd, &destlen, buf, complen-8 );
		header[0] = 'C';
	}

	// 写入文件
	CFile outfile;
	if( !outfile.Open(strOut,CFile::modeCreate|CFile::modeWrite) )
	{
		AfxMessageBox( "输出路径无效" );
		return;
	}

	outfile.Write(header,8);
	outfile.Write(bufd,destlen);
	outfile.Close();
	::GlobalFree(header);
	::GlobalFree(buf);
	::GlobalFree(bufd);

	AfxMessageBox( bCompress ? "解压成功" : "压缩成功" );
}