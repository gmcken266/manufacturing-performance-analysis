USE ManufacturingAnalytics;

---- Which machine has the highest percentage of scrap relative to its output?

SELECT
    m.MachineName,
    SUM(p.OutputQty) AS TotalOutput,
    SUM(p.ScrapQty) AS TotalScrap,
    SUM(p.ScrapQty) * 100.0 /SUM(p.OutputQty) AS ScrapToOutputPercent
FROM Production p
INNER JOIN Machines m
    ON p.MachineID = m.MachineID
GROUP BY m.MachineName
ORDER BY ScrapToOutputPercent DESC;

-- Compare only production of the same component: Turbine Blade (PartID 103).

SELECT
    m.MachineName,
    SUM(p.OutputQty) AS TotalOutput,
    SUM(p.ScrapQty) AS TotalScrap,
    SUM(p.ScrapQty) * 100.0 / SUM(p.OutputQty)AS ScrapToOutputPercent,
    AVG(p.ActualCycleTimeSeconds * 1.0) AS AverageCycleTime
FROM Production p
INNER JOIN Machines m
    ON p.MachineID = m.MachineID
WHERE p.PartID = 103
GROUP BY m.MachineName
ORDER BY ScrapToOutputPercent DESC;


-- Investigate the daily scrap trend for Machine 4

SELECT
    ProductionDate,
    OutputQty,
    ScrapQty,
    TargetQty,
    ActualCycleTimeSeconds,
    TargetQty - OutputQty AS OutputShortfall,
    ScrapQty * 100.0 / OutputQty AS ScrapToOutputPercent
FROM Production
WHERE MachineID = 4
  AND PartID = 103
ORDER BY ProductionDate;

