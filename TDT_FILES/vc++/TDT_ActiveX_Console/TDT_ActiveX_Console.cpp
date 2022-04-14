// TDT_ActiveX_Console.cpp : Defines the entry point for the console application.
//

#include <conio.h>

#import "C:\\TDT\\lib\\RPcoX.ocx"

RPCOXLib::_DRPcoXPtr RP;

#define OUTFILE       "C:\\TDT\\ActiveX\\ActXExamples\\vc++\\fnoise2.f32"
#define CIRCUIT_PATH  "C:\\TDT\\ActiveX\\ActXExamples\\RP_files\\Continuous_Acquire.rcx"
#define INDEX_TAG     "index"
#define DATA_TAG      "dataout"

void transerr() {
	printf("Error transferring data.\n");
}

int main(int argc, char* argv[])
{
	//Initialize ActiveX object
	HRESULT hr;
	hr = CoInitialize(NULL);
	if (FAILED(hr)) {
		printf("Failed to initialize COM!\n");
	}
	const char* appId = "{d323a625-1d13-11d4-8858-444553540000}"; //"RPcoX.ocx"
	hr = RP.CreateInstance(appId);

	if (FAILED(hr)) {
		printf("CreateInstance for %s failed!\n", appId);
	}
	else {
		printf("Successfully initialized TDT ActiveX interface %s\n", appId);
	}

	if (0 == RP) return -1;
	//

	//TDT connect to hardware and load/run circuit
	if (RP->ConnectRZ6("GB",1))
		printf("Connected to RZ6\n");
	else {
		printf("failed to connect to RZ6\n");
		return -1;
	}
	if (!RP->ClearCOF()) {  
		printf("ClearCOF failed\n");
		return -1;
	}
	if (RP->LoadCOF(CIRCUIT_PATH))
		printf("Circuit %s loaded\n", CIRCUIT_PATH);
	else {
		printf("Failed to load %s\n", CIRCUIT_PATH);
		return -1;
    }
	if (RP->Run())
		printf("Circuit running\n");
	else {
		printf("Failed to run %s\n", CIRCUIT_PATH);
		return -1;
	}
	//

	int buffer_size = (int)RP->GetTagSize(DATA_TAG);
	int      bufpts = buffer_size / 2;
	float samp_rate = RP->GetSFreq();
	
	float     *data = new float[bufpts];
	FILE      *fout = fopen(OUTFILE, "wb");

	//begin acquisition
	printf("Writing to %s\n", OUTFILE);
	printf("Press any key to halt circuit and exit\n");
	RP->SoftTrg(1);
	
	bool acquire   = true;
	bool high      = false;
	unsigned int samples_acquired = 0;
	int offset     = 0;
	float curindex = 0;

	while(acquire)
	{
		curindex = RP->GetTagVal(INDEX_TAG);

		if(high)
			while(curindex > bufpts)
			{
				Sleep(100);
				curindex = RP->GetTagVal(INDEX_TAG);
			}
		else 
			while(curindex < bufpts) 
			{
				Sleep(100);
				curindex = RP->GetTagVal(INDEX_TAG);
			}
		
		// read segment and write it to file
			if (RP->ReadTag(DATA_TAG, data, offset, bufpts) == 0)
			transerr();

		//write buffer
		fwrite(data, sizeof(float), bufpts, fout);

		samples_acquired += bufpts;
		printf("%d samples acquired\r", samples_acquired);
		fflush(stdout);
		
		// check to see if data is transferring fast enough
		curindex = RP->GetTagVal(INDEX_TAG);
		if(high) {
			if (curindex > bufpts) 
			{
				transerr();
				RP->SoftTrg(2);
				RP->Halt();
				acquire = false;
			}
		}
		else
		{
			if (curindex < bufpts) 
			{
				transerr();
				RP->SoftTrg(2);
				RP->Halt();
				acquire = false;
			}
		}

		// set for next time
		high = !high;
		offset = -offset + bufpts; // 0->bufpts, bufpts->0

		if(kbhit())
			break;
	}

	// clean up
	fclose(fout);
	RP->SoftTrg(2);
	RP->Halt();

	return 0;
}