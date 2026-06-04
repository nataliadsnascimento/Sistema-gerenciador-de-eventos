CREATE TABLE IF NOT EXISTS pago (
    id_pagamento INT PRIMARY KEY,
    valor DECIMAL(10, 2) NOT NULL,
    opcao_pagamento VARCHAR(50) NOT NULL,
    data_vencimento DATE NOT NULL,
    comprovante VARCHAR(255),
    FOREIGN KEY (id_pagamento) REFERENCES pagamento(id_pagamento) ON DELETE CASCADE
);