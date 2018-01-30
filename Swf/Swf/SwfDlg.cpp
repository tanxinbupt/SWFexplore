// SwfDlg.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "Swf.h"
#include "SwfDlg.h"
#include "include/zlib.h"
#pragma comment(lib, "lib/zlib.lib")

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


// CSwfDlg �Ի���


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


// CSwfDlg ��Ϣ�������

BOOL CSwfDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// ���ô˶Ի����ͼ�ꡣ��Ӧ�ó��������ڲ��ǶԻ���ʱ����ܽ��Զ�
	//  ִ�д˲���
	SetIcon(m_hIcon, TRUE);			// ���ô�ͼ��
	SetIcon(m_hIcon, FALSE);		// ����Сͼ��

	// TODO: �ڴ���Ӷ���ĳ�ʼ������

	return TRUE;  // ���ǽ��������õ��ؼ������򷵻� TRUE
}

// �����Ի��������С����ť������Ҫ����Ĵ���
//  �����Ƹ�ͼ�ꡣ����ʹ���ĵ�/��ͼģ�͵� MFC Ӧ�ó���
//  �⽫�ɿ���Զ���ɡ�

void CSwfDlg::OnPaint()
{
	if (IsIconic())
	{
		CPaintDC dc(this); // ���ڻ��Ƶ��豸������

		SendMessage(WM_ICONERASEBKGND, reinterpret_cast<WPARAM>(dc.GetSafeHdc()), 0);

		// ʹͼ���ڹ����������о���
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// ����ͼ��
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

//���û��϶���С������ʱϵͳ���ô˺���ȡ�ù��
//��ʾ��
HCURSOR CSwfDlg::OnQueryDragIcon()
{
	return static_cast<HCURSOR>(m_hIcon);
}


void CSwfDlg::OnBnClickedOpen1()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	char oldPath[MAX_PATH];	// ���浱ǰ����Ŀ¼
	GetCurrentDirectory( MAX_PATH, oldPath );

	// �� �򿪶Ի���
	static char BASED_CODE szFilter[] = "SWF Files (*.swf)|*.swf||";
	CFileDialog dlg(1,"swf",NULL,OFN_HIDEREADONLY | OFN_OVERWRITEPROMPT,szFilter,0,0);
	if(dlg.DoModal()==IDOK)
	{
		//��ȡ�ļ���
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
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	char oldPath[MAX_PATH];
	GetCurrentDirectory( MAX_PATH, oldPath );

	char szPath[MAX_PATH];     //���ѡ���Ŀ¼·�� 
	CString str;

	ZeroMemory(szPath, sizeof(szPath));   

	BROWSEINFO bi;   
	bi.hwndOwner = m_hWnd;   
	bi.pidlRoot = NULL;   
	bi.pszDisplayName = szPath;   
	bi.lpszTitle = "��ѡ����Ҫ�����Ŀ¼��";   
	bi.ulFlags = 0;   
	bi.lpfn = NULL;   
	bi.lParam = 0;   
	bi.iImage = 0;   
	//����ѡ��Ŀ¼�Ի���
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
		AfxMessageBox("��Ч��Ŀ¼��������ѡ��");
	}

	SetCurrentDirectory( oldPath );
}

void CSwfDlg::OnBnClickedDowork()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������

	CString strIn;	// �����ļ���
	CString strOut;	// ����ļ���
	CEdit* pInEdit=(CEdit*)GetDlgItem( IDC_INPUT );
	CEdit* pOutEdit=(CEdit*)GetDlgItem( IDC_OUTPUT );
	pInEdit->GetWindowText(strIn);
	pOutEdit->GetWindowText(strOut);

	CFile infile;
	if( !infile.Open( strIn, CFile::modeRead ) )
	{	
		AfxMessageBox( "�޷����ļ�" );
		return;
	}

	DWORD complen=(DWORD)infile.GetLength();	// ��ȡ�ļ�����
	BYTE* header=(BYTE*)::GlobalAlloc(GPTR,8);	// ����swf�ļ�ͷ�洢�ռ�
	infile.Read(header,8);						// ��ȡswf�ļ�ͷ
	DWORD filelen = *(DWORD*)(header+4);		// ��ȡ�ļ���Ϣ�е��ļ�����

	// �򵥲���һ���Ƿ�Ϊ������swf�ļ�
	if ( !( (header[0] == 'C' || header[0] == 'F') && header[1] == 'W' && header[2] == 'S' ) || complen > filelen )
	{
		AfxMessageBox( "�ļ���ΪSWF�ļ�" );
		infile.Close();
		return;
	}

	// �����ļ�����
	BYTE* buf=(BYTE*)::GlobalAlloc(GPTR,complen-8);
	BYTE* bufd=(BYTE*)::GlobalAlloc(GPTR,filelen-8);

	// ��ȡԴswf����
	infile.Read(buf,complen-8);
	infile.Close();

	unsigned long destlen;	// ѹ��/��ѹ��ĳ���

	// �����ļ�ͷѡ��ѹ��/��ѹ
	bool bCompress = header[0] == 'C';
	if( bCompress )
	{
		// ��ѹ�����޸��ļ�ͷ��Ϣ
		uncompress( bufd, &destlen, buf, complen-8 );
		header[0] = 'F';
	}
	else
	{
		// ѹ�������޸��ļ�ͷ��Ϣ
		compress( bufd, &destlen, buf, complen-8 );
		header[0] = 'C';
	}

	// д���ļ�
	CFile outfile;
	if( !outfile.Open(strOut,CFile::modeCreate|CFile::modeWrite) )
	{
		AfxMessageBox( "���·����Ч" );
		return;
	}

	outfile.Write(header,8);
	outfile.Write(bufd,destlen);
	outfile.Close();
	::GlobalFree(header);
	::GlobalFree(buf);
	::GlobalFree(bufd);

	AfxMessageBox( bCompress ? "��ѹ�ɹ�" : "ѹ���ɹ�" );
}