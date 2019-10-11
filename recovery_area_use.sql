select space_limit/1024/1024/1024 as space_in_gb, 
trunc(space_used/1024/1024/1024, 2) as USED_IN_GB, 
trunc(space_reclaimable/1024/1024/1024,2) as reclaim_IN_GB,
number_of_files
from v$recovery_file_dest;
