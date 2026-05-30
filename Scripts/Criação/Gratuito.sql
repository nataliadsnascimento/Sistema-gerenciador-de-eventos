CREATE TABLE IF NOT EXISTS gratuito (
    id_pagamento INT PRIMARY KEY,
    cota_social BOOLEAN NOT NULL,
    motivo_isencao TEXT,
    comprovante_isencao VARCHAR(255),
    FOREIGN KEY (id_pagamento) REFERENCES pagamento(id_pagamento) ON DELETE CASCADE
);