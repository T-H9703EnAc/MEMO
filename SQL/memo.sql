WITH YKJ AS ( 
    SELECT
        TC1.CODE_NAME AS DIR_TYPE_NAME,
        TC2.CODE_NAME AS COMMODITY_CATEGORY_NAME,
        MDYS.DIR_TYPE,
        MDYS.COMMODITY_CATEGORY,
        MDYS.CONTRACE_VOL / 1000 AS CONTRACT_VOL 
    FROM
        M_RESOURCE_MASTER RM 
    LEFT OUTER JOIN V_MMS_DELTA_KW_YAKUJO_SUM MDYS 
        ON RM.RESOURCE_KANRI_NO = MDYS.RESOURCE_KANRI_NO 
        AND MDYS.POW_DELIVERY_DATE = :targetDate 
        AND MDYS.BLOCK_NO = '1' 
    LEFT OUTER JOIN T_CODE TC1 
        ON CONCAT(TC1.CODE_ID, '00') = MDYS.COMMODITY_CATEGORY 
        AND TC1.TARGET_ID = 'COMMODITY_CATEGORY' 
    LEFT OUTER JOIN T_CODE TC2 
        ON TC2.CODE_ID = MDYS.DIR_TYPE 
        AND TC2.TARGET_ID = 'DIR_TYPE' 
    WHERE
        RM.RESOURCE_KANRI_NO = :resourceKanriNO 
        AND RM.START_YYYYMMDD <= :startDay 
        AND RM.END_YYYYMMDD >= :endtDay
) 

SELECT
    DIR_TYPE_NAME,
    COMMODITY_CATEGORY_NAME,
    DIR_TYPE,
    COMMODITY_CATEGORY,
    CONTRACT_VOL 
FROM
    YKJ 
WHERE
    (
        -- 条件1: 商品区分に4000が存在する場合はそのまま取得
        COMMODITY_CATEGORY = '4000'
    )
    OR
    (
        -- 条件2: 商品区分が3200、3100、2200のいずれかを持ち、かつ条件1のレコードがない場合に最小の商品区分の値のレコードのみ抽出
        COMMODITY_CATEGORY IN ('3200', '3100', '2200')
        AND (
            SELECT
                COUNT(*)
            FROM
                YKJ 
            WHERE
                COMMODITY_CATEGORY IN ('4000', '2100', '1000')
            ) = 0 
            AND (
                SELECT
                    COUNT(*)
                FROM
                    YKJ 
                WHERE
                    COMMODITY_CATEGORY IN ('3200', '3100', '2200')
                ) > 1 
            AND COMMODITY_CATEGORY = (
                SELECT
                    MIN(COMMODITY_CATEGORY)
                FROM
                    YKJ 
                WHERE
                    COMMODITY_CATEGORY IN ('3000', '3100', '2200')
            )
    )
    OR
    (
        -- 条件3: 商品区分が3200、3100、2200、2100、1000のいずれかを持ち、かつ条件1と条件2のレコードがない場合にそのまま取得
        COMMODITY_CATEGORY IN ('3200', '3100', '2200', '2100', '1000')
        AND (
            SELECT
                COUNT(*)
            FROM
                YKJ 
            WHERE
                COMMODITY_CATEGORY IN ('3200', '3100', '2200')
            ) = 0 
            AND (
                SELECT
                    COUNT(*)
                FROM
                    YKJ 
                WHERE
                    COMMODITY_CATEGORY = '4000'
                ) = 0 
    )
    OR
    (
        -- 条件4: 商品区分が3200、3100、2200、2100、1000のいずれかが1つだけある場合にそのまま取得
        COMMODITY_CATEGORY IN ('3200', '3100', '2200', '2100', '1000')
        AND (
            SELECT
                COUNT(DISTINCT COMMODITY_CATEGORY)
            FROM
                YKJ 
            WHERE
                COMMODITY_CATEGORY IN ('3200', '3100', '2200', '2100', '1000')
            ) = 1
    );
