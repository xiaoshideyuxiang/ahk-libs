ITL_StructureConstructor(this, ptr = 0, noInit = false)
{
	local hr, rcinfo := this.base["internal://rcinfo-instance"]

	if (!ptr)
	{
		ptr := DllCall(NumGet(NumGet(rcinfo+0), 16*A_PtrSize, "Ptr"), "Ptr", rcinfo, "Ptr") ; IRecordInfo::RecordCreate()
		if (!ptr)
		{
			throw Exception(ITL_FormatException("Failed to create an instance of the """ this.base["internal://typeinfo-name"] """ structure."
											, "IRecordInfo::RecordCreate() failed."
											, ErrorLevel, ""
											, !ptr, "Invalid instance pointer: " ptr)*)
		}
	}
	else if (!noInit)
	{
		hr := DllCall(NumGet(NumGet(rcinfo+0), 03*A_PtrSize, "Ptr"), "Ptr", rcinfo, "Ptr", ptr, "Int") ; IRecordInfo::RecordInit()
		if (ITL_FAILED(hr))
		{
			;throw Exception("RecordInit() failed.", -1, ITL_FormatError(hr))
			throw Exception(ITL_FormatException("Failed create an instance of the """ this.base["internal://typeinfo-name"] """ structure."
											, "IRecordInfo::RecordInit() failed."
											, ErrorLevel, hr)*)
		}
	}

	this["internal://type-instance"] := ptr
}