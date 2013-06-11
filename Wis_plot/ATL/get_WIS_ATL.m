function get_WIS_ATL(outfile)

%get_file = ['X:\Atlantic\Evaluation\WW3\Model\',outfile(end-6:end),'\'];
get_file = ['/mnt/CHL_WIS_1/ATL/Production/Model/',outfile(end-6:end),'/'];
if ~exist(outfile,'dir')
    mkdir(outfile);
end
cd(outfile);
loc{1} = [outfile,'/level1'];
loc{2} = [outfile,'/level2'];
loc{3} = [outfile,'/level3N'];
loc{4} = [outfile,'/level3C'];
loc{5} = [outfile,'/level3S1'];
loc{6} = [outfile,'/level3S2'];

year = outfile(end-6:end-3);
mon = outfile(end-1:end);

for zz = 1:length(loc)
    if ~exist(loc{zz},'dir')
        mkdir(loc{zz});
    end
    cd (loc{zz})
    ii = strfind(loc{zz},'level');
    levn = loc{zz}(ii+5:end);
    copyfile([get_file,'LEVEL',levn,'/*-LEVEL', ...
        levn,'-MMt.tgz'],'.');
    fnamest = [get_file,'LEVEL',levn,'/*-LEVEL', ...
            levn,'-ST-onlns.tgz'];
    blah = dir(fnamest);
    if ~isempty(blah)
        copyfile(fnamest,'.');
    end
    wis_read('ATL',year,mon,'/')
    
end
archive_atl(year,mon);
system(['rm -rf ',outfile]);
end