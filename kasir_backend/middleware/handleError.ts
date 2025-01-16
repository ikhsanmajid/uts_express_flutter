import { PrismaClientKnownRequestError, PrismaClientValidationError, PrismaClientUnknownRequestError } from "@prisma/client/runtime/library";
import { Request, Response, NextFunction } from "express";

export const handleError = (err: Error | PrismaClientKnownRequestError | PrismaClientUnknownRequestError | PrismaClientValidationError, req: Request, res: Response, next: NextFunction) => {
    if (err instanceof PrismaClientKnownRequestError) {
        return res.status(400).json({ status: "error", message: err.message, code: err.code });
    }

    if (err instanceof PrismaClientUnknownRequestError) {
        return res.status(500).json({ status: "error", message: err.message });
    }

    if (err instanceof PrismaClientValidationError) {
        return res.status(400).json({ status: "error", message: err.message });
    }

    return res.status(500).json({ status: "error", message: err.message });
}