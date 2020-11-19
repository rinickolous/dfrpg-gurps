function onInit()
	aSpellTypeData_old = DataCommonGURPS.aSpellTypeData;
	aSpellTypeAbbrData_old = DataCommonGURPS.aSpellTypeData;
	
	DataCommonGURPS.aSpellTypeData = aSpellTypeData;
	DataCommonGURPS.aSpellTypeAbbrData = aSpellTypeData
end

aSpellTypeData = {
	"IQ/Average",
	"IQ/Hard",
	"IQ/Very Hard",
};

aSpellTypeAbbrData = {
	"IQ/A",
	"IQ/H",
	"IQ/VH",
};
