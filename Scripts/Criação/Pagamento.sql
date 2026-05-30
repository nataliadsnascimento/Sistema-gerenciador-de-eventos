CREATE TABLE IF NOT EXISTS pagamento (
    id_pagamento INT PRIMARY KEY,
    id_inscricao INT NOT NULL, 
    FOREIGN KEY (id_pagamento) REFERENCES inscricao(id_inscricao) ON DELETE CASCADE
);