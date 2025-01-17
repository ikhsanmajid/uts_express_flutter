import { PrismaClientKnownRequestError, PrismaClientValidationError, PrismaClientUnknownRequestError } from "@prisma/client/runtime/library";
import { randomUUID } from "crypto";
import { Request, Response, NextFunction } from "express";

export const handleError = (err: Error | PrismaClientKnownRequestError | PrismaClientUnknownRequestError | PrismaClientValidationError, req: Request, res: Response, next: NextFunction) => {
    if (err instanceof PrismaClientKnownRequestError) {
        if (err.code === "P2003"){
            return res.status(400).json({ status: "error", message: `input ${err.meta?.field_name} tidak sesuai/tidak ada`})
        }

        if (err.code === "P2002"){
            return res.status(400).json({ status: "error", message: `input ${err.meta?.target} sudah ada`})
        }

        return res.status(400).json({ status: "error", message: "Input tidak sesuai/duplikat", meta: err.meta?.field_name });
    }

    if (err instanceof PrismaClientUnknownRequestError) {
        return res.status(500).json({ status: "error", message: "Internal Server Error", request_id: randomUUID() });
    }

    if (err instanceof PrismaClientValidationError) {
        return res.status(400).json({ status: "error", message: `input field tidak lengkap` });
    }

    return res.status(500).json({ status: "error", message: "Internal Server Error", request_id: randomUUID() });
}