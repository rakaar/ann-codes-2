// CircuitLoaderDlg.cpp : implementation file
//

#include "stdafx.h"
#include "CircuitLoader.h"
#include "CircuitLoaderDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#undef THIS_FILE
static char THIS_FILE[] = __FILE__;
#endif

/////////////////////////////////////////////////////////////////////////////
// CAboutDlg dialog used for App About

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// Dialog Data
	//{{AFX_DATA(CAboutDlg)
	enum { IDD = IDD_ABOUTBOX };
	//}}AFX_DATA

	// ClassWizard generated virtual function overrides
	//{{AFX_VIRTUAL(CAboutDlg)
	protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support
	//}}AFX_VIRTUAL

// Implementation
protected:
	//{{AFX_MSG(CAboutDlg)
	//}}AFX_MSG
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
	//{{AFX_DATA_INIT(CAboutDlg)
	//}}AFX_DATA_INIT
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CAboutDlg)
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
	//{{AFX_MSG_MAP(CAboutDlg)
		// No message handlers
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCircuitLoaderDlg dialog

CCircuitLoaderDlg::CCircuitLoaderDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CCircuitLoaderDlg::IDD, pParent)
{
	//{{AFX_DATA_INIT(CCircuitLoaderDlg)
	m_radio_interface = -1;
	m_radio_rp = -1;
	m_devnum_text = _T("");
	m_status_label = _T("");
	//}}AFX_DATA_INIT
	m_hIcon = AfxGetApp()->LoadIcon(IDR_MAINFRAME);

}

void CCircuitLoaderDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	//{{AFX_DATA_MAP(CCircuitLoaderDlg)
	DDX_Control(pDX, BUTTON_LOAD, m_load_button);
	DDX_Control(pDX, BUTTON_CANCEL, m_cancel_button);
	DDX_Radio(pDX, RADIO_USB, m_radio_interface);
	DDX_Radio(pDX, RADIO_RP2, m_radio_rp);
	DDX_Text(pDX, EDIT_DEVNUM, m_devnum_text);
	DDV_MaxChars(pDX, m_devnum_text, 1);
	DDX_Control(pDX, RA16_1, m_ra16_1);
	DDX_Control(pDX, RA16_2, m_ra16_2);
	DDX_Control(pDX, RA16_3, m_ra16_3);
	DDX_Control(pDX, RA16_4, m_ra16_4);
	DDX_Control(pDX, RA16_5, m_ra16_5);
	DDX_Control(pDX, RA16_6, m_ra16_6);
	DDX_Control(pDX, RA16_7, m_ra16_7);
	DDX_Control(pDX, RA16_8, m_ra16_8);
	DDX_Control(pDX, RL2_1, m_rl2_1);
	DDX_Control(pDX, RL2_2, m_rl2_2);
	DDX_Control(pDX, RL2_3, m_rl2_3);
	DDX_Control(pDX, RL2_4, m_rl2_4);
	DDX_Control(pDX, RL2_5, m_rl2_5);
	DDX_Control(pDX, RL2_6, m_rl2_6);
	DDX_Control(pDX, RL2_7, m_rl2_7);
	DDX_Control(pDX, RL2_8, m_rl2_8);
	DDX_Control(pDX, RP2_1, m_rp2_1);
	DDX_Control(pDX, RP2_2, m_rp2_2);
	DDX_Control(pDX, RP2_3, m_rp2_3);
	DDX_Control(pDX, RP2_4, m_rp2_4);
	DDX_Control(pDX, RP2_5, m_rp2_5);
	DDX_Control(pDX, RP2_6, m_rp2_6);
	DDX_Control(pDX, RP2_7, m_rp2_7);
	DDX_Control(pDX, RP2_8, m_rp2_8);
	DDX_Control(pDX, RV8_1, m_rv8_1);
	DDX_Control(pDX, RV8_2, m_rv8_2);
	DDX_Control(pDX, RV8_3, m_rv8_3);
	DDX_Control(pDX, RV8_4, m_rv8_4);
	DDX_Control(pDX, RV8_5, m_rv8_5);
	DDX_Control(pDX, RV8_6, m_rv8_6);
	DDX_Control(pDX, RV8_7, m_rv8_7);
	DDX_Control(pDX, RV8_8, m_rv8_8);
	DDX_Control(pDX, IDC_COMMONDIALOG1, m_openfile_dialog);
	DDX_Text(pDX, STATUS_LABEL, m_status_label);
	//}}AFX_DATA_MAP
}

BEGIN_MESSAGE_MAP(CCircuitLoaderDlg, CDialog)
	//{{AFX_MSG_MAP(CCircuitLoaderDlg)
	ON_WM_SYSCOMMAND()
	ON_WM_PAINT()
	ON_WM_QUERYDRAGICON()
	ON_BN_CLICKED(BUTTON_LOAD, OnLoadClick)
	ON_BN_CLICKED(BUTTON_CANCEL, OnCancelClick)
	ON_EN_CHANGE(EDIT_DEVNUM, OnChangeDevnum)
	//}}AFX_MSG_MAP
END_MESSAGE_MAP()

/////////////////////////////////////////////////////////////////////////////
// CCircuitLoaderDlg message handlers

BOOL CCircuitLoaderDlg::OnInitDialog()
{
	CDialog::OnInitDialog();

	// Add "About..." menu item to system menu.

	// IDM_ABOUTBOX must be in the system command range.
	ASSERT((IDM_ABOUTBOX & 0xFFF0) == IDM_ABOUTBOX);
	ASSERT(IDM_ABOUTBOX < 0xF000);

	CMenu* pSysMenu = GetSystemMenu(FALSE);
	if (pSysMenu != NULL)
	{
		CString strAboutMenu;
		strAboutMenu.LoadString(IDS_ABOUTBOX);
		if (!strAboutMenu.IsEmpty())
		{
			pSysMenu->AppendMenu(MF_SEPARATOR);
			pSysMenu->AppendMenu(MF_STRING, IDM_ABOUTBOX, strAboutMenu);
		}
	}

	SetIcon(m_hIcon, TRUE);			// Set big icon
	SetIcon(m_hIcon, FALSE);		// Set small icon
	
	m_devnum_text = "1"; // set device number 1 as default
	m_status_label = "No circuits loaded.";
	UpdateData(FALSE);
	CheckRadioButton(RADIO_RP2, RADIO_RL2, RADIO_RP2); // select rp2 as default
	CheckRadioButton(RADIO_USB, RADIO_GIGABIT, RADIO_USB); // select usb as default

	return TRUE;  // return TRUE  unless you set the focus to a control
}

void CCircuitLoaderDlg::OnSysCommand(UINT nID, LPARAM lParam)
{
	if ((nID & 0xFFF0) == IDM_ABOUTBOX)
	{
		CAboutDlg dlgAbout;
		dlgAbout.DoModal();
	}
	else
	{
		CDialog::OnSysCommand(nID, lParam);
	}
}

// If you add a minimize button to your dialog, you will need the code below
//  to draw the icon.  For MFC applications using the document/view model,
//  this is automatically done for you by the framework.

void CCircuitLoaderDlg::OnPaint() 
{
	if (IsIconic())
	{
		CPaintDC dc(this); // device context for painting

		SendMessage(WM_ICONERASEBKGND, (WPARAM) dc.GetSafeHdc(), 0);

		// Center icon in client rectangle
		int cxIcon = GetSystemMetrics(SM_CXICON);
		int cyIcon = GetSystemMetrics(SM_CYICON);
		CRect rect;
		GetClientRect(&rect);
		int x = (rect.Width() - cxIcon + 1) / 2;
		int y = (rect.Height() - cyIcon + 1) / 2;

		// Draw the icon
		dc.DrawIcon(x, y, m_hIcon);
	}
	else
	{
		CDialog::OnPaint();
	}
}

HCURSOR CCircuitLoaderDlg::OnQueryDragIcon()
{
	return (HCURSOR) m_hIcon;
}


long CCircuitLoaderDlg::RunCircuit(CRPcoX &rp, CString filepath, CString devtype,
								   CString inter, int devnum) {
	if (devtype == "RP2")
		rp.ConnectRP2(inter, devnum);
	else if (devtype == "RA16")
		rp.ConnectRA16(inter, devnum);
	else if (devtype == "RV8")
		rp.ConnectRV8(inter, devnum);
	else
		rp.ConnectRL2(inter, devnum);
	rp.ClearCOF();
	rp.LoadCOF(filepath);
	rp.Run();
	return rp.GetStatus();
}


CRPcoX& CCircuitLoaderDlg::GetRP(CString devtype, int devnum) {
	if (devtype == "RP2")
		switch(devnum) {
			case 1: return m_rp2_1;
			case 2: return m_rp2_2;
			case 3: return m_rp2_3;
			case 4: return m_rp2_4;
			case 5: return m_rp2_5;
			case 6: return m_rp2_6;
			case 7: return m_rp2_7;
			case 8: 
			default: return m_rp2_8;
		}
	else if (devtype == "RA16") 
		switch(devnum) {
			case 1: return m_ra16_1;
			case 2: return m_ra16_2;
			case 3: return m_ra16_3;
			case 4: return m_ra16_4;
			case 5: return m_ra16_5;
			case 6: return m_ra16_6;
			case 7: return m_ra16_7;
			case 8: 
			default: return m_ra16_8;
		}
	else if (devtype == "RV8") 
		switch(devnum) {
			case 1: return m_rv8_1;
			case 2: return m_rv8_2;
			case 3: return m_rv8_3;
			case 4: return m_rv8_4;
			case 5: return m_rv8_5;
			case 6: return m_rv8_6;
			case 7: return m_rv8_7;
			case 8: 
			default: return m_rv8_8;
		}
	else 
		switch(devnum) {
			case 1: return m_rl2_1;
			case 2: return m_rl2_2;
			case 3: return m_rl2_3;
			case 4: return m_rl2_4;
			case 5: return m_rl2_5;
			case 6: return m_rl2_6;
			case 7: return m_rl2_7;
			case 8: 
			default: return m_rl2_8;
		}
}


void CCircuitLoaderDlg::OnLoadClick() {
	m_openfile_dialog.ShowOpen();
	CString filepath = m_openfile_dialog.GetFileName();

	CString interface_str;
	switch(GetCheckedRadioButton(RADIO_USB, RADIO_GIGABIT)) {
		case RADIO_USB:
			interface_str = "USB";
			break;
		default:
			interface_str = "GIGABIT";
	}

	CString device_type;
	int devnum = atoi(m_devnum_text);
	long status;
	switch(GetCheckedRadioButton(RADIO_RP2, RADIO_RL2)) {
		case RADIO_RP2:
			device_type = "RP2";
			break;
		case RADIO_RA16:
			device_type = "RA16";
			break;
		case RADIO_RV8:
			device_type = "RV8";
			break;
		case RADIO_RL2:
		default:
			device_type = "RL2";
	}

	status = RunCircuit(GetRP(device_type, devnum), filepath, device_type, interface_str, devnum);
	if ((status & 0x07) != 0x07) 
		m_status_label.Format("Error loading circuit on %s #%d", device_type, devnum);
	else 
		m_status_label.Format("Circuit loaded on %s #%d", device_type, devnum);
	UpdateData(FALSE);
}


void CCircuitLoaderDlg::OnCancelClick() {
	HaltAll();
	CDialog::OnCancel();
}


void CCircuitLoaderDlg::HaltAll() {
	m_rp2_1.Halt();
	m_rp2_2.Halt();
	m_rp2_3.Halt();
	m_rp2_4.Halt();
	m_rp2_5.Halt();
	m_rp2_6.Halt();
	m_rp2_7.Halt();
	m_rp2_8.Halt();
	m_ra16_1.Halt();
	m_ra16_2.Halt();
	m_ra16_3.Halt();
	m_ra16_4.Halt();
	m_ra16_5.Halt();
	m_ra16_6.Halt();
	m_ra16_7.Halt();
	m_ra16_8.Halt();
	m_rv8_1.Halt();
	m_rv8_2.Halt();
	m_rv8_3.Halt();
	m_rv8_4.Halt();
	m_rv8_5.Halt();
	m_rv8_6.Halt();
	m_rv8_7.Halt();
	m_rv8_8.Halt();
	m_rl2_1.Halt();
	m_rl2_2.Halt();
	m_rl2_3.Halt();
	m_rl2_4.Halt();
	m_rl2_5.Halt();
	m_rl2_6.Halt();
	m_rl2_7.Halt();
	m_rl2_8.Halt();
}


void CCircuitLoaderDlg::OnChangeDevnum() {
	CString tempstr;
	tempstr = m_devnum_text; // save old text so we can set it back if error
	UpdateData(TRUE);
	if ((atoi(m_devnum_text) < 1) || (atoi(m_devnum_text) > 8)) {
		AfxMessageBox("Error: device number must be between 1 and 8.");
		m_devnum_text = tempstr;
		UpdateData(FALSE);
	}
		
}
