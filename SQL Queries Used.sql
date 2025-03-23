--SQL Queries Used


--Code to get the cost per minute of each flight
SELECT segmentsairlinename, (totalfare / (CAST(segmentsdurationinseconds AS BIGINT)/60)) AS cost_per_minute 

FROM itineraries 


--Code to get the cost per mile of each flight
SELECT segmentsairlinename, (totalfare / totaltraveldistance) AS cost_per_mile 

FROM itineraries; 

--Code to get the average cost per mile of each airline
SELECT segmentsairlinename, AVG(totalfare / totaltraveldistance) AS avg_cost_per_mile 

FROM itineraries 

GROUP BY segmentsairlinename 

ORDER BY avg_cost_per_mile ASC; 

--Code to get the average cost per mile of each airline based on if the flights are economy or not
SELECT segmentsairlinename, isbasiceconomy, AVG(totalfare / totaltraveldistance) AS avg_cost_per_mile 

FROM itineraries 

GROUP BY segmentsairlinename, isbasiceconomy 

ORDER BY segmentsairlinename, avg_cost_per_mile ASC; 

--Code to get the average cost per mile of each airline based on if the the flights are economy or not
--and if there are 5 or less seats remaining on the flight or not
SELECT segmentsairlinename, isbasiceconomy, CASE WHEN seatsremaining <= 5 THEN '≤ 5 seats left' ELSE '> 5 seats left' END AS seatsremaining, AVG(totalfare / totaltraveldistance) AS avg_cost_per_mile  

FROM itineraries  

GROUP BY segmentsairlinename, isbasiceconomy, CASE WHEN seatsremaining <= 5 THEN '≤ 5 seats left' ELSE '> 5 seats left' END  

ORDER BY avg_cost_per_mile; 
