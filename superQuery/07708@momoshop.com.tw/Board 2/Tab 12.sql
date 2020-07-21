SELECT 
CASE
    -- _1：近3個月銷量為0、近一年銷量為0
    -- _2：近3個月銷量為0、近一年銷量不為0
    -- _3：近3個月銷量不為0、近一年銷量為0
    -- _4：近3個月銷量不為0、近一年銷量不為0
    WHEN (category = '1' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '1_1'
    WHEN (category = '1' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '1_2'
    WHEN (category = '1' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '1_3'
    WHEN (category = '1' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '1_4'
    WHEN (category = '2' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '2_1'
    WHEN (category = '2' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '2_2'
    WHEN (category = '2' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '2_3'
    WHEN (category = '2' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '2_4'
    WHEN (category = '3' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '3_1'
    WHEN (category = '3' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '3_2'
    WHEN (category = '3' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '3_3'
    WHEN (category = '3' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '3_4'
    WHEN (category = '4' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '4_1'
    WHEN (category = '4' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '4_2'
    WHEN (category = '4' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '4_3'
    WHEN (category = '4' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '4_4'
    WHEN (category = '5' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '5_1'
    WHEN (category = '5' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '5_2'
    WHEN (category = '5' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '5_3'
    WHEN (category = '5' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '5_4'
    WHEN (category = '6' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '6_1'
    WHEN (category = '6' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '6_2'
    WHEN (category = '6' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '6_3'
    WHEN (category = '6' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '6_4'
    WHEN (category = '8' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = true) THEN '8_1'
    WHEN (category = '8' AND Order_3m_Never_BeSold_Good = true AND Order_1y_Never_BeSold_Good = false) THEN '8_2'
    WHEN (category = '8' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = true) THEN '8_3'
    WHEN (category = '8' AND Order_3m_Never_BeSold_Good = false AND Order_1y_Never_BeSold_Good = false) THEN '8_4'
    ELSE '0'
    END
AS category2,
*
FROM `momo-develop._3b7a5bd540a8dfd341e57f295848b5793cf3d3ab.anon561eeca6_369c_4d51_9d2f_b23e7f437906`
-- GROUP BY category