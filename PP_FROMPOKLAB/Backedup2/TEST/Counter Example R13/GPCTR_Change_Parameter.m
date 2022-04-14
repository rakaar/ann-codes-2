function varargout = GPCTR_Change_Parameter(varargin)
%GPCTR_CHANGE_PARAMETER calls ni library with the appropriate arguments.
%
% The C declaration for this function is the following:
%	  extern i16 _stdcall GPCTR_Change_Parameter ( i16 deviceNumber, u32 gpCounterNumber, u32 paramID, u32 paramValue); 
%
% The MATLAB Declaration looks like the following:
%	int16 GPCTR_Change_Parameter(int16, uint32, uint32, uint32)
%
% This function will call loadlibrary on the library if needed.
% This file is automatically generated by the loadlibrarygui.
%
%   See also
%   LOADLIBRARY, UNLOADLIBRARY, LOADNI, UNLOADNI

%
%
% $Author: $
% $Revision: $
% $Date: 24-Dec-2002 11:30:13 $
%
% Local Functions Defined:
%
%
% $Notes:
%
%
%
%
% $EndNotes
%
% $Description:
%
%
%
%
% $EndDescription


if nargin==0;
	help(mfilename);
	return;
end;


% If Library is loaded already unload it.

if ~libisloaded('ni')
	loadni;
end;


if nargin~=4;
	error(mfilename:WrongNumberIn,'Incorrect number of input arguments.');
end;

if nargout~=1;
	error(mfilename:WrongNumberOut,'Incorrect number of output arguments.');
end;

% Call external function in loaded DLL.
[varargout{1}]=calllib('ni','GPCTR_Change_Parameter',varargin{:});

